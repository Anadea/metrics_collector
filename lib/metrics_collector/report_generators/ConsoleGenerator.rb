# frozen_string_literal: true

module ConsoleGenerator
  class << self
    def call(metrics)
      metrics.each { |metric, result| puts "#{metric}: #{result}" }
    end
  end
end
