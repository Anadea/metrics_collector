# require_relative '../helper.rb'

class RubycriticHandler
  class << self
    def call(metrics)
      run_rubycritic
      collect_data(metrics)
    end

    private

    def run_rubycritic
      system('rubycritic --format json')
    end

    def collect_data(metrics)
      rubycritic_file = MetricsCollector::CONFIG.rubycritic_output_path

      return "#{rubycritic_file} not found" unless File.exist?(rubycritic_file)

      rubycritic = File.read('tmp/rubycritic/report.json')
      rubycritic_result = JSON.parse(rubycritic)
      metrics[:rubycritic_score] = rubycritic_result.dig(*MetricsCollector::CONFIG.rubycritic_score)
    end
  end
end
