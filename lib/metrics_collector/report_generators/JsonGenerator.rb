require 'json'

module JsonGenerator
  class << self
    def call(metrics)
      generate_json(metrics)
    end

    private

    def generate_json(metrics)
      File.open('public/metrics.json', 'w') do |json|
        json.write(metrics.to_json)
        puts 'Json generated, check public/metrics.json'
      end
    end
  end
end
