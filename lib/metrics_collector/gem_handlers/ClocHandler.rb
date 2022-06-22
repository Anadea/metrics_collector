# require_relative '../helper.rb'

class ClocHandler
  class << self
    def call(metrics)
      check_availability
      run_cloc
      collect_data(metrics)
    end

    private

    def check_availability
      system("apt-get install -y cloc") unless system("ldconfig -p | grep cloc")
    end

    def run_cloc
      cloc = File.open(".clocignore", "w") {|f| f.write("node_modules\ntmp\npublic") }
      system("cloc --json --out=stats.json --exclude-dir=$(tr '\n' ',' < .clocignore) .")
    end

    def collect_data(metrics)
      return 'stats.json not found (cloc)' unless File.exist?('stats.json')

      cloc = File.read('stats.json')
      cloc_result = JSON.parse(cloc)
      metrics[:Cloc_total_lines] = cloc_result['header']['n_lines']
      metrics[:Cloc_total_files] = cloc_result['header']['n_files']
    end
  end
end
