# require_relative '../helper.rb'

class BrakemanHandler
  class << self
    def call(metrics)
      run_brakeman
      collect_data(metrics)
    end

    private

    # def check_availability
    #   system("gem install brakeman -v 5.1.2") unless system("gem list -i brakeman")
    # end

    def run_brakeman
      system('brakeman -f json -o public/brakeman.json --force')
    end

    def collect_data(metrics)
      # return 'brakeman.json not found' unless File.exist?('brakeman.json')

      brakeman = File.read('public/brakeman.json')
      brakeman_result = JSON.parse(brakeman)
      metrics[:Brakeman_errors]           = brakeman_result['scan_info']['errors']
      metrics[:Brakeman_warnings]         = brakeman_result['scan_info']['security_warnings']
      metrics[:Brakeman_ignored_warnings] = brakeman_result['scan_info']['ignored_warnings']
    end
  end
end
