require_relative 'helper'

class Resolver
  def initialize(libraries, output, channels, token)
    @libraries = validate_libs(libraries)
    @output    = validate_outputs(output)
    @channels  = channels
    @token     = token
  end

  def call
    metrics = MetricsCollector.call(@libraries)
    generate_reports(metrics)
  end

  private

  def generate_reports(metrics)
    paths = ReportsHandler.call(@output, metrics)
    SlackNotifier.new(@channels, @token, @output, metrics, paths).call
  end

  def validate_libs(libraries)
    return SupportedLibs::SUPPORTED_LIBRARIES if libraries.nil?
    raise 'One of the requested libraries is not supported' if (libraries - SupportedLibs::SUPPORTED_LIBRARIES).any?

    libraries
  end

  def validate_outputs(output)
    return SupportedOutput::SUPPORTED_OUTPUT if output.nil?
    raise 'One of the requested outputs is not supported' if (output - SupportedOutput::SUPPORTED_OUTPUT).any?

    output
  end
end
