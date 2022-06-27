require_relative 'metrics_collector/helper'
require 'active_support/inflector'

module MetricsCollector
  require 'railtie' if defined?(Rails)

  class Error < StandardError; end

  class << self
    METRICS = {}

    def call(libraries)
      collect_metrics(libraries)
      METRICS
    end

    private

    def collect_metrics(libraries)
      libraries = libraries.split(' ') unless libraries.is_a?(Array)
      handlers = libraries.map(&:downcase).map(&:capitalize).map{ |lib| lib + 'Handler' }

      handlers.each do |library|
        library.constantize.call(METRICS)
      end
    end
  end
end
