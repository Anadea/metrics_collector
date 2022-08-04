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
      system('apt-get install -y cloc') unless system('ldconfig -p | grep cloc')
    end

    def run_cloc
      system("cloc --json --out=stats.json --exclude-dir=#{MetricsCollector::CONFIG.cloc_ignored_directories} .")
    end

    def collect_data(metrics)
      cloc_file = MetricsCollector::CONFIG.cloc_report_path

      return "#{cloc_file} not found (cloc)" unless File.exist?(cloc_file)

      cloc = File.read('stats.json')
      cloc_result = JSON.parse(cloc)
      metrics[:cloc_total_lines] = cloc_result.dig(*MetricsCollector::CONFIG.cloc_total_lines)
      metrics[:cloc_total_files] = cloc_result.dig(*MetricsCollector::CONFIG.cloc_total_files)
    end
  end
end
