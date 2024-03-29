require_relative 'helper'
require_relative 'report_generators/SpreadsheetUploader'

class Resolver
  def initialize(libraries, output, channels, token, spreadsheet, client_secret)
    @libraries     = validate_libs(libraries)
    @output        = validate_outputs(output)
    @channels      = channels
    @token         = token
    @client_secret = client_secret
    @spreadsheet   = spreadsheet
  end

  def call
    metrics = MetricsCollector.call(@libraries)
    generate_reports(metrics)
  end

  private

  def generate_reports(metrics)
    paths = ReportsHandler.call(@output, metrics)
    SlackNotifier.new(@channels, @token, @output, metrics, paths).call
    MetricsCollector::SpreadsheetUploader.new(metric_values(metrics), @spreadsheet, @client_secret).call
  end

  def metric_values(metrics)
    metrics_values = Hash[ metrics.sort_by { |key, val| key.to_s } ].values
    metrics_values.unshift(Time.now.strftime("%d %b %Y"))
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
