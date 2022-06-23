# frozen_string_literal: true

# lib/railtie.rb
require 'metrics_collector'
require 'rails'

module MetricsCollector
  class Railtie < Rails::Railtie
    railtie_name :MetricsCollector

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |file| load file }
    end
  end
end
