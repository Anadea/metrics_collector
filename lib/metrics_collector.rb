# frozen_string_literal: true

require_relative 'metrics_collector/helper'

module MetricsCollector
  require 'railtie' if defined?(Rails)

  class Error < StandardError; end

  class << self
    METRICS = {}.freeze

    def call(libraries)
      collect_metrics(libraries)
      METRICS
    end

    private

    def collect_metrics(libraries)
      libraries.each do |library|
        "#{library.downcase.capitalize}Handler".constantize.call(METRICS)
      end
    end
  end
end
