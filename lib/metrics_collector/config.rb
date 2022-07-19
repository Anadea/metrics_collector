# frozen_string_literal: true

require 'yaml'

module MetricsCollector
  class Config
    # TODO
    # DEFAULT_CONFIG = File.join('config', 'default.yml')
    # USER_CONFIG    = '.metrics_collector.yml'.freeze

    def call
      # TODO RETURN DEFAULT CONFIG UNLESS EXTERNAL CONFIG EXISTS
      merge_configs(default_config, external_config)
    end

    private

    def default_config
      YAML.load_file("config/default.yml")
    end

    def external_config
      YAML.load_file(".metrics_collector.yml")
      # TODO YAML.load_file("#{RAILS_ROOT}/.metrics_collector.yml")
    end

    def merge_configs(default, external, &block)
      default = default.dup
      external.each_pair do |key, value|
        default_key = default[key]
        if default_key.is_a?(Hash) && value.is_a?(Hash)
          default[key] = merge_configs(default_key, value, &block)
        else
          default[key] = block && default_key ? block.call(key, default_key, value) : value
        end
      end

      default
    end
  end

  class ConfigObject
    def initialize
      @config = MetricsCollector::Config.new.call
    end

    def simplecov_output_path
      @config['simplecov']['report_path'][0]
    end

    def simplecov_total_coverage
      @config['simplecov']['coverage_path'][0].split(',').collect(&:strip)
    end

    def rubycritic_output_path
      @config['rubycritc']['report_path'][0]
    end

    def rubycritic_score
      @config['rubycritc']['score_path'][0].split(',').collect(&:strip)
    end

    def cloc_report_path
      @config['cloc']['report_path'][0]
    end

    def cloc_total_lines
      @config['cloc']['total_lines_path'][0].split(',').collect(&:strip)
    end

    def cloc_total_files
      @config['cloc']['total_files_path'][0].split(',').collect(&:strip)
    end

    def brakeman_errors
      @config['scan_info']['errors'][0].split(',').collect(&:strip)
    end

    def brakeman_security_warnings
      @config['scan_info']['security_warnings'][0].split(',').collect(&:strip)
    end

    def brakeman_ignored_warnings
      @config['scan_info']['ignored_warnings'][0].split(',').collect(&:strip)
    end
  end
end
