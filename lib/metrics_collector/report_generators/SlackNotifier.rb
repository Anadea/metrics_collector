require "httparty"

class SlackNotifier
  class << self
    def call(metrics)
      response = HTTParty.post("https://hooks.slack.com/services/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",
        body: { text: metrics }.to_json,
        # title: { text: 'project name would be here' }.to_json,
        headers: {'Content-Type': 'application/json'}
      )
    end
  end
end

SlackNotifier.call({:Cloc_total_lines=>445310, :Cloc_total_files=>1888, :Brakeman_errors=>nil, :Brakeman_warnings=>7, :Brakeman_ignored_warnings=>nil, :Rubycritic_score=>70.47}.to_json)

SlackNotifier.call(
  "Cloc_total_lines,445310\n
  Cloc_total_files,1888\n
  Brakeman_errors,\n
  Brakeman_warnings,7\n
  Brakeman_ignored_warnings,\n
  Rubycritic_score,70.47"
)

# require 'json'

# # require 'httparty'

# # module SlackNotifier
# #   include HTTParty
  
# #   class << self
# #     def call
# #       # return unless ENV['SLACK_GENERAL_HOOK'].present?

# #       HTTParty.post(
# #         "https://hooks.slack.com/services/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",
# #         body: {
# #           message: 'test class method'
# #         }.to_json,
# #         headers: { 'Content-Type' => 'application/json' }
# #       )

# #       # system(curl -X POST -H 'Content-type: application/json' --data '{"text":"Test"}' https://hooks.slack.com/services/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)
# #     end
# #   end
# # end

# # SlackNotifier.call


# # curl -X POST -H 'Content-type: application/json' --data '{"text":"test again"}' https://hooks.slack.com/services/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

# # require "faraday"
# # require 'uri'

# # params = {title: "PROJECT TITLE", body: "METRICS WOULD BE HERE", 'userID' => 1}
# # p encoded_params = URI.encode_www_form(params)
# # p response = Faraday.post("https://hooks.slack.com/services/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", params)
# # p response.status
# # p response.body
# # #  if response.status == 201



# # require 'http'
# # response = HTTP.post("https://hooks.slack.com/services/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", :form => {'title' => 'project title would be here', 'body' => 'METRICS', 'userID' => 1})
# # p response.parse

# response = HTTParty.post("https://hooks.slack.com/services/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",
#   :body => {:text => 'please work'}.to_json,
#   :headers => {'Content-Type' => 'application/json'}
# )


# class SlackNotifier
#   # include HTTParty
#   base_uri 'https://hooks.slack.com/services/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'

#   def initialize()

#   end

#   def send_metrics(title, body)
#     params = { body: { title: title, body: body }.to_json }
#     self.class.post("/posts", params).parsed_response
#   end
# end

# slack_notifier = SlackNotifier.new()
# p slack_notifier.send_metrics("title for project", "TEST CLASS METHOD")


# require 'uri'
# require 'net/http'

# p uri = URI('https://hooks.slack.com/services/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')
# p res = Net::HTTP.post_form(uri, 'title' => 'please', 'body' => 'work', 'userID' => 1)
# puts res.body  if res.is_a?(Net::HTTPSuccess)



# require 'net/http'
# require 'uri'

# def get_metrics()
#   uri = URI.parse("https://hooks.slack.com/services/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")
#   http = Net::HTTP.new(uri.host, uri.port)
#   request = Net::HTTP::Get.new(uri.request_uri)
#   user_agent = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.86 Safari/537.36'
#   request.initialize_http_header({"User-Agent" => user_agent})

#   response = http.request(request)
#   puts response.inspect 
#  end

# get_metrics()
