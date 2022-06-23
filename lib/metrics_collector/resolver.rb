# frozen_string_literal: true

require_relative 'helper'

module Resolver
  class << self
    def call(libraries, output)
      check_params(libraries, output)
      metrics = call_handlers(libraries)
      generate_reports(output, metrics)
    end

    private

    def call_handlers(libraries)
      libraries = check_libs(libraries)
      MetricsCollector.call(libraries.split(' '))
    end

    def generate_reports(output, metrics)
      output = check_output(output)
      ReportsHandler.call(output.split(' '), metrics)
    end

    def check_libs(libraries)
      return SupportedLibs::SUPPORTED_LIBRARIES if libraries.nil? || libraries == 'all'

      libraries
    end

    def check_output(output)
      return SupportedOutput::SUPPORTED_OUTPUT if output.nil? || output == 'all'

      output
    end

    def check_params(libraries, output)
      if !libraries.nil?
        unless (libraries.split(' ').map(&:downcase) - SupportedLibs::SUPPORTED_LIBRARIES.split(' ').map(&:downcase)).empty?
          raise 'One of the requested libraries is not supported'
        end
      end

      if !output.nil?
        unless (output.split(' ').map(&:downcase) - SupportedOutput::SUPPORTED_OUTPUT.split(' ').map(&:downcase)).empty?
          raise 'One of the requested outputs is not supported'
        end
      end
    end
  end
end
