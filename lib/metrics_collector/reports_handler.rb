require_relative 'helper.rb'

module ReportsHandler
  class << self
    def call(output, metrics)
      generate_reports(output, metrics)
    end

    private

    def generate_reports(output, metrics)
      output.each do |option|
        (option.downcase.capitalize + 'Generator').constantize.call(metrics)
      end
    end
  end
end
