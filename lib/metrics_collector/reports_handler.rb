require_relative 'helper'

module ReportsHandler
  class << self
    def call(output, metrics)
      generate_reports(output, metrics)
    end

    private

    def generate_reports(output, metrics)
      output = output.split(' ') unless output.is_a?(Array)
      output.each do |option|
        "#{option.downcase.capitalize}Generator".constantize.call(metrics)
      end
    end
  end
end
