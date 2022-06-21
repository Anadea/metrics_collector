# frozen_string_literal: true

require_relative 'metrics_collector/version'
require_relative 'BrakemanHandler.rb'
require_relative 'ClocHandler.rb'
require_relative 'RubycriticHandler.rb'
require_relative 'SimplecovHandler.rb'
require_relative '../helper.rb'

module MetricsCollector
  require 'railtie.rb' if defined?(Rails)

  class Error < StandardError; end

  class << self
    METRICS = {}

    def full_download
      collect_metrics
      generate_json
      generate_csv
    end

    def console_output
      METRICS.each { |metric, result| puts "#{metric}: #{result}" }
    end
  
    def collect_metrics
      BrakemanHandler.call(METRICS)
      ClocHandler.call(METRICS)
      RubycriticHandler.call(METRICS)
      Simplecov.call(METRICS)
    end
  
    def clean_generated_files
      system('rm stats.json brakeman.json tmp/rubycritic/report.json .clocignore')
    end
  
    def generate_csv
      CSV.open("public/metrics.csv", "wb") do |csv|
        csv << [Time.now.utc.strftime("%d/%m/%Y %H:%M"), 'dd/mm/yy']
        METRICS.to_a.each { |metric| csv << metric }
      end
    end
  
    def generate_json
      File.open("public/metrics.json","w") do |json|
        json.write(METRICS)
        'File generated, check public/'
      end
    end

  end
end
