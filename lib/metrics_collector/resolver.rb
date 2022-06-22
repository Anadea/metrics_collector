require_relative 'helper.rb'

module Resolver
  class << self
    def call(libraries, output)
      metrics = call_handlers(libraries)
      generate_reports(output, metrics)
    end

    private

    def call_handlers(libraries)
      libraries = check_libs(libraries)
      MetricsCollector.call(libraries.split(" "))
    end

    def generate_reports(output, metrics)
      output = check_output(output)
      ReportsHandler.call(output.split(" "), metrics)
    end

    def check_libs(libraries)
      return SupportedLibs::SUPPORTED_LIBRARIES if (libraries.nil? || libraries == 'all')

      libraries
    end

    def check_output(output)
      return SupportedOutput::SUPPORTED_OUTPUT if (output.nil? || output == 'all')

      output
    end
  end
end
