class ConsoleGenerator
  def initialize(metrics)
    @metrics = metrics
  end

  def call
    @metrics.each { |metric, result| puts "#{metric}: #{result}" }
  end
end
