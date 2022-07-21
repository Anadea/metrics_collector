require_relative 'helper'
require_relative 'report_generators/SpreadsheetUploader'

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
    SpreadsheetUploader.new(metrics).update_spreadsheet # TODO if config exists for google and -s(--spreadsheet) flag passed
  end

  def validate_libs(libraries)
    return ['cloc', 'brakeman', 'simplecov', 'rubycritic'] if libraries.nil?

    libraries
  end

  def validate_outputs(output)
    return ['csv', 'json', 'console'] if output.nil?

    output
  end
end
