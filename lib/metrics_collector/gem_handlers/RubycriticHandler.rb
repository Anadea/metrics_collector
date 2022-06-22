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
      return 'tmp/rubycritic/report.json not found' unless File.exist?('tmp/rubycritic/report.json')

      rubycritic = File.read('tmp/rubycritic/report.json')
      rubycritic_result = JSON.parse(rubycritic)
      metrics[:Rubycritic_score] = rubycritic_result['score']
    end
  end
end
