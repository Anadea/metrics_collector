require 'json'

class JsonGenerator
  def initialize(metrics)
    @metrics   = metrics
    @file_name = "#{Date.today.strftime("%e_%b_%Y_")}metrics.json"
  end

  def call
    generate_json
    @file_name
  end

  private

  def generate_json
    File.open("public/#{@file_name}", 'w') do |json|
      json.write(@metrics.to_json)
      puts "Json generated, check public/#{@file_name}"
    end
  end
end
