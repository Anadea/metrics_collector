require_relative 'helper'

module Resolver
  class << self
    def call(libraries, output, channels, token)
      validate_libs(libraries)
      validate_outputs(output)

      metrics = call_handlers(libraries)
      generate_reports(output, metrics, channels, token)
    end

    private

    def call_handlers(libraries)
      libraries = check_libs(libraries)
      MetricsCollector.call(libraries)
    end

    def generate_reports(output, metrics, channels, token)
      output = check_output(output)
      paths = ReportsHandler.call(output, metrics)
      SlackNotifier.new(channels, token, output, metrics, paths).call
    end

    def check_libs(libraries)
      return SupportedLibs::SUPPORTED_LIBRARIES if libraries.nil? || libraries == 'all'

      libraries
    end

    def check_output(output)
      return SupportedOutput::SUPPORTED_OUTPUT if output.nil? || output == 'all'

      output
    end

    def validate_libs(libraries)
      return if libraries == 'all'

      if !libraries.nil?
        unless (libraries - SupportedLibs::SUPPORTED_LIBRARIES)
          raise 'One of the requested libraries is not supported'
        end
      end
    end

    def validate_outputs(output)
      return if output == 'all'

      if !output.nil?
        unless (output - SupportedOutput::SUPPORTED_OUTPUT)
          raise 'One of the requested outputs is not supported'
        end
      end
    end
  end
end
