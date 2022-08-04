# require_relative '../helper.rb'

class BrakemanHandler
  class << self
    def call(metrics)
      run_brakeman
      collect_data(metrics)
    end

    private

    def run_brakeman
      system('brakeman -f json -o public/brakeman.json --force')
    end

    def collect_data(metrics)
      return 'brakeman.json not found' unless File.exist?('public/brakeman.json')

      brakeman = File.read('public/brakeman.json')
      brakeman_result = JSON.parse(brakeman)
      metrics[:brakeman_errors]           = brakeman_result.dig(*MetricsCollector::CONFIG.brakeman_errors)
      metrics[:brakeman_warnings]         = brakeman_result.dig(*MetricsCollector::CONFIG.brakeman_security_warnings)
      metrics[:brakeman_ignored_warnings] = brakeman_result.dig(*MetricsCollector::CONFIG.brakeman_ignored_warnings)
    end
  end
end
