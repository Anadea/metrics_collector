require_relative 'report_generators/ConsoleGenerator'
require_relative 'report_generators/JsonGenerator'
require_relative 'report_generators/CsvGenerator'
require_relative 'report_generators/SlackNotifier'

module ReportsHandler
  class << self
    def call(output, metrics)
      generate_reports(output, metrics)
    end

    private

    def generate_reports(outputs, metrics)
      outputs = outputs.map(&:downcase)
      paths = {}
      paths['csv']  = generate_csv(metrics)  if outputs.include? 'csv'
      paths['json'] = generate_json(metrics) if outputs.include? 'json'
      paths
    end

    def generate_csv(metrics)
      CsvGenerator.new(metrics).call
    end

    def generate_json(metrics)
      JsonGenerator.new(metrics).call
    end
  end
end
