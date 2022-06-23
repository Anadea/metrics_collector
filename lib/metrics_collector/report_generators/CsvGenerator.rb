module CsvGenerator
  class << self
    def call(metrics)
      generate_csv(metrics)
    end

    private

    def generate_csv(metrics)
      CSV.open('public/metrics.csv', 'wb') do |csv|
        csv << [Time.now.utc.strftime('%d/%m/%Y %H:%M'), 'dd/mm/yy']
        metrics.to_a.each { |metric| csv << metric }
      end
    end
  end
end
