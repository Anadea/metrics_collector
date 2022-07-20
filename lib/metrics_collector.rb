require_relative 'metrics_collector/gem_handlers/BrakemanHandler'
require_relative 'metrics_collector/gem_handlers/ClocHandler'
require_relative 'metrics_collector/gem_handlers/RubycriticHandler'
require_relative 'metrics_collector/gem_handlers/SimplecovHandler'
require_relative 'metrics_collector/config'

module MetricsCollector
  require 'railtie' if defined?(Rails)

  class Error < StandardError; end

  CONFIG = ConfigObject.new

  class << self
    METRICS = {}

    def call(libraries)
      collect_metrics(libraries)
      METRICS
    end

    private

    def collect_metrics(libraries)
      libraries = libraries.map(&:downcase)

      BrakemanHandler.call(METRICS)   if libraries.include? 'brakeman'
      ClocHandler.call(METRICS)       if libraries.include? 'cloc'
      RubycriticHandler.call(METRICS) if libraries.include? 'rubycritic'
      SimplecovHandler.call(METRICS)  if libraries.include? 'simplecov'
    end
  end
end
