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

    def generate_reports(output, metrics)
      paths = {}
      output.each do |option|
        generate_file = "#{option.downcase.capitalize}Generator".constantize.new(metrics).call
        paths[option] = generate_file unless option == 'console'
      end

      paths
    end
  end
end
