class CsvGenerator
  def initialize(metrics)
    @metrics   = metrics
    @file_name = "#{Date.today.strftime("%e_%b_%Y_")}metrics.csv"
  end

  def call
    generate_csv
    @file_name
  end

  private

  def generate_csv
    CSV.open("public/#{@file_name}", 'wb') do |csv|
      @metrics.to_a.each { |metric| csv << metric }
    end

    puts "CSV generated, check public/#{@file_name}"
  end
end
