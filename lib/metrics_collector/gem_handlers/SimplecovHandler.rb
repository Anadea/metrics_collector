class SimplecovHandler
  class << self
    def call(metrics)
      collect_data(metrics)
    end

    private

    def collect_data(metrics)
      return 'public/coverage/.last_run.json not found' unless File.exist?('public/coverage/.last_run.json')

      simplecov = File.read('public/coverage/.last_run.json')
      simplecov_result = JSON.parse(simplecov)
      metrics[:Coverage] = simplecov_result['result']['line']
      # METRICS[:Coverage] = simplecov_result['result']['covered_percent']
    end
  end
end
