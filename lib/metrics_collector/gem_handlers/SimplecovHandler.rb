class SimplecovHandler
  class << self
    def call(metrics)
      collect_data(metrics)
    end

    private

    def collect_data(metrics)
      simplecov_file = MetricsCollector::CONFIG.simplecov_output_path

      return "#{simplecov_file} not found" unless File.exist?(simplecov_file)

      simplecov = File.read('public/coverage/.last_run.json')
      simplecov_result = JSON.parse(simplecov)
      metrics[:coverage] = simplecov_result.dig(*MetricsCollector::CONFIG.simplecov_total_coverage)
    end
  end
end
