require 'net/http'
require 'uri'

class SlackNotifier
	class << self
		def call(oauth) # pass formatted requested outputs
			p '0' * 80
			p oauth
			uri = URI.parse("https://slack.com/api/files.upload")
			token = oauth

			headers = {
				'Accept' => 'multipart/form-data',
				'Content-Type' => 'multipart/form-data',
				'Authorization' => "Bearer #{token}"
			}

			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true


			request = Net::HTTP::Post.new(uri.request_uri, headers)
			form_data = [['file', File.open('public/metrics.json')],
									 ['channels', 'C03NFLHAVD3']
									]

			request.set_form form_data, 'multipart/form-data'


			response = http.request(request)

			p response.body
		end
	end
end


		# private

		# def send_json
		#  curl -F file=@public/metrics.json -F 'initial_comment=nines local test' -F channels=C03NFLHAVD3 -H 'Authorization: Bearer xoxb-146698882176-3766561096947-HfWwuJqnvdR1n0ddrzX6YrId' https://slack.com/api/files.upload"
		# end

		# def send_csv
		# 	system("curl -F file=@public/metrics.csv -F 'initial_comment=nines local test' -F channels=C03NFLHAVD3 -H 'Authorization: Bearer xoxb-146698882176-3766561096947-HfWwuJqnvdR1n0ddrzX6YrId' https://slack.com/api/files.upload")
		# end

# class CrAiSlackJob < ActiveJob::Base
#   queue_as :default

#   def perform(contact_request_id)
#     @contact_request = ContactRequest.find(contact_request_id)
#     ai_spam_process

#     return if @contact_request.spam

#     CrSlackJob.perform_later @contact_request.id
#     CrEmailJob.perform_later @contact_request.id
#     CrPipedriveJob.perform_later @contact_request.id
#   end

#   private

#   def ai_spam_process
#     return unless @contact_request.message.present?

#     require 'net/http'
#     require 'uri'
#     require 'json'

#     uri = URI.parse("https://ai-api.localhost8080.pp.ua/models/api/v1/translated-multilabel-spam/")
#     token = ENV['AI_SPAM_TOKEN']
#     headers = {
#       'Accept' => 'application/json',
#       'Content-Type' => 'application/json',
#       'Authorization' => "Token #{token}"
#     }
#     body = { text: @contact_request.message }

#     # Create the HTTP objects
#     http = Net::HTTP.new(uri.host, uri.port)
#     http.use_ssl = true if uri.instance_of? URI::HTTPS

#     request = Net::HTTP::Post.new(uri.request_uri, headers)
#     request.body = body.to_json

#     # Send the request
#     response = http.request(request)
#     model_response = JSON.parse(response.body)

#     return unless model_response['labels']

#     @contact_request.spam = model_response['labels'].include?('is_spam')
#     @contact_request.data['labels'] = model_response['labels']
#     @contact_request.save

#     Slack::AiContactNotifier.ping(
#       @contact_request,
#       model_response['labels'],
#       response.body
#     )
#   end
# end




# require 'slack-ruby-client'
# # require 'pry'

# path_to_file = "metrics.json"
# filetype = 'json'

# def send_file(client,data,path_to_file,filetype)
#   puts "getting logs for #{data['user']}"

#   # client.web_client.chat_postMessage channel: data['#metrics_collector-webhook'], as_user: true, text: "<@#{data['user']}>, requested file"

#   client.web_client.files_upload(channels: data['channel'], as_user: true, 
#                                  initial_comment: "<@#{data['user']}>, attached is the file you requested.",
#                                  file: Faraday::UploadIO.new("#{path_to_file}","#{filetype}"), 
#                                  title: File.basename(path_to_file),
#                                  filename: File.basename(path_to_file)
#                                 )x
# end

# Slack.configure do |config|
#   config.token = config.token = "xoxb-146698882176-3766561096947-HfWwuJqnvdR1n0ddrzX6YrId" #ENV['SLACKBOT_API_TOKEN']
#   # config.token = 'xoxp-146698882176-2315747133040-3772393748053-8f7ce5ac455996322c389186cda4448f' #ENV['USER_API_TOKEN']
# end

# curl -F file=@metrics.json -F "initial_comment=class test" -F channels=C03NFLHAVD3 -H "Authorization: Bearer xoxb-146698882176-3766561096947-HfWwuJqnvdR1n0ddrzX6YrId" https://slack.com/api/files.upload
# # system("curl -F file=@metrics.json -F 'initial_comment=curl attachment' -H 'Authorization: Bearer xoxb-146698882176-3766561096947-HfWwuJqnvdR1n0ddrzX6YrId' https://slack.com/api/files.upload")

# curl -F file=@metrics.json -F "initial_comment=class test" -H "Authorization: Bearer xoxb-146698882176-3766561096947-HfWwuJqnvdR1n0ddrzX6YrId" https://slack.com/api/files.upload


# pp client = Slack::RealTime::Client.new

# client.on :hello do
#   puts "Successfully connected, welcome '#{client.self['name']}' to the '#{client.team['name']}'" +
#        "team at https://#{client.team['domain']}.slack.com."
# end

# client.on :message do |data|
#   puts data
#   case data['text']
#     when /OpsBot.*send me a file/i then
#       send_file(client,data,path_to_file,filetype)
#     when /OpsBot.*another command/i then
#       #some_function(client,data)
#   end
# end
# # binding.pry


# p client.start!
# p client.auth_test

# curl -F file=@public/metrics.json -F "initial_comment=user test" -F channels=C03NFLHAVD3 -H "Authorization: Bearer xoxe.xoxp-1-Mi0yLTE0NjY5ODg4MjE3Ni0yMzE1NzQ3MTMzMDQwLTM3NzQ4NjM4MjQ2NDItMzc3NzI4MjI2NTU1Ni02NDdiYmRjYzFjZDdlOTk5ZjFmYTZjNDc1OWY0ZTU5YjEwZTc4MDVkYzQ2Yjg3Y2MyNmVmOWEwYmM1NjBmMDgy" https://slack.com/api/files.upload
# curl -F file=@public/metrics.json -F "initial_comment=user test" -F channels=C03NFLHAVD3 -H "Authorization: Bearer xoxp-146698882176-2315747133040-3782723692659-8b84f30f6bb7389b053be5d6455fe2d7" https://slack.com/api/files.upload



# xoxb-146698882176-3766561096947-HfWwuJqnvdR1n0ddrzX6YrId






# filetype = 'json'



# require "httparty"

# class SlackNotifier
#   path_to_file = "metrics.json"

#   class << self
#     def call
#       response = HTTParty.post("https://hooks.slack.com/services/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",
#         body: { file: File.new("metrics.json"), text: 'test' }.to_json,
#         # title: { text: 'project name would be here' }.to_json,
#         headers: {'Content-Type': 'application/json'}
#       )
      
#     end
#   end
# end

# SlackNotifier.call

# # SlackNotifier.call(
# #   "Cloc_total_lines,445310\n
# #   Cloc_total_files,1888\n
# #   Brakeman_errors,\n
# #   Brakeman_warnings,7\n
# #   Brakeman_ignored_warnings,\n
# #   Rubycritic_score,70.47"
# # )


# require 'slack/incoming/webhooks'


# # slack.post "Test gem"

# slack = Slack::Incoming::Webhooks.new "https://hooks.slack.com/services/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"

# text = "Cloc_total_lines: 284412\n
# Cloc_total_files: 1828\n
# Brakeman_errors:\n
# Brakeman_warnings: 4\n
# Brakeman_ignored_warnings:\n 
# Coverage: 9.4\n
# Rubycritic_score: 66.15\n"


# attachment = {
# 	"blocks": [
# 		{
# 			"type": "header",
# 			"text": {
# 				"type": "plain_text",
# 				"text": "Metrics result",
# 				"emoji": true
# 			}
# 		},
#     {
# 			"type": "section",
# 			"fields": [
# 				{
# 					"type": "mrkdwn",
# 					"text": text
# 				}
# 			]
# 		},
# 		{
# 			"type": "section",
# 			"fields": [
# 				{
# 					"type": "mrkdwn",
# 					"text": "*Metrics:*\n<https://newgit.anadea.co/anadea/studio-340/ninegolf/-/jobs/256763/artifacts/raw/public/metrics.json|JSON>"
# 				}
# 			]
# 		},
# 		{
# 			"type": "section",
# 			"fields": [
# 				{
# 					"type": "mrkdwn",
# 					"text": "*Metrics:*\n<https://newgit.anadea.co/anadea/studio-340/ninegolf/-/jobs/256763/artifacts/file/public/metrics.csv|CSV>"
# 				}
# 			]
# 		},
# 		{
# 			"type": "section",
# 			"text": {
# 				"type": "mrkdwn",
# 				"text": "<https://newgit.anadea.co/anadea/studio-340/ninegolf/-/jobs/256763|View pipeline>"
# 			}
# 		}
# 	]
# }

# # slack.attachments = [ attachment ]
# slack.post 'try', attachments: [attachment]




# # # attachments = {
# # #   fallback: "????",
# # #   color: "#36a64f",
# # #   pretext: "above attachment text",
# # #   title: "Pipeline",
# # #   title_link: "https://newgit.anadea.co/anadea/studio-340/ninegolf/-/jobs/256763",
# # #   text: "attachment text here",
# # #   image_url: "https://assets.petco.com/petco/image/upload/c_pad,dpr_1.0,f_auto,q_auto,h_636,w_636/c_pad,h_636,w_636/905909-Center-1"
# # # }





# # # slack = Slack::Incoming::Webhooks.new "https://hooks.slack.com/services/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"
# # # , attachments: [attachments]
# # # slack.username = 'username'
# # # slack.attachments = [{ color: '#36a64f',  title: 'Test' }]
# # # slack.post "attachment"
















# # # require 'json'

# # # # require 'httparty'

# # # # module SlackNotifier
# # # #   include HTTParty
  
# # # #   class << self
# # # #     def call
# # # #       # return unless ENV['SLACK_GENERAL_HOOK'].present?

# # # #       HTTParty.post(
# # # #         "https://hooks.slack.com/services/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",
# # # #         body: {
# # # #           message: 'test class method'
# # # #         }.to_json,
# # # #         headers: { 'Content-Type' => 'application/json' }
# # # #       )

# # # #       # system(curl -X POST -H 'Content-type: application/json' --data '{"text":"Test"}' https://hooks.slack.com/services/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)
# # # #     end
# # # #   end
# # # # end

# # # # SlackNotifier.call


# # # # curl -X POST -H 'Content-type: application/json' --data '{"text":"test again"}' https://hooks.slack.com/services/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

# # # # require "faraday"
# # # # require 'uri'

# # # # params = {title: "PROJECT TITLE", body: "METRICS WOULD BE HERE", 'userID' => 1}
# # # # p encoded_params = URI.encode_www_form(params)
# # # # p response = Faraday.post("https://hooks.slack.com/services/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", params)
# # # # p response.status
# # # # p response.body
# # # # #  if response.status == 201



# # # # require 'http'
# # # # response = HTTP.post("https://hooks.slack.com/services/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", :form => {'title' => 'project title would be here', 'body' => 'METRICS', 'userID' => 1})
# # # # p response.parse

# # # response = HTTParty.post("https://hooks.slack.com/services/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",
# # #   :body => {:text => 'please work'}.to_json,
# # #   :headers => {'Content-Type' => 'application/json'}
# # # )


# # # class SlackNotifier
# # #   # include HTTParty
# # #   base_uri 'https://hooks.slack.com/services/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'

# # #   def initialize()

# # #   end

# # #   def send_metrics(title, body)
# # #     params = { body: { title: title, body: body }.to_json }
# # #     self.class.post("/posts", params).parsed_response
# # #   end
# # # end

# # # slack_notifier = SlackNotifier.new()
# # # p slack_notifier.send_metrics("title for project", "TEST CLASS METHOD")


# # # require 'uri'
# # # require 'net/http'

# # # p uri = URI('https://hooks.slack.com/services/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')
# # # p res = Net::HTTP.post_form(uri, 'title' => 'please', 'body' => 'work', 'userID' => 1)
# # # puts res.body  if res.is_a?(Net::HTTPSuccess)

# # # require 'net/http'
# # # require 'uri'

# # # def get_metrics()
# # #   uri = URI.parse("https://hooks.slack.com/services/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")
# # #   http = Net::HTTP.new(uri.host, uri.port)
# # #   request = Net::HTTP::Get.new(uri.request_uri)
# # #   user_agent = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.86 Safari/537.36'
# # #   request.initialize_http_header({"User-Agent" => user_agent})

# # #   response = http.request(request)
# # #   puts response.inspect 
# # #  end

# # # get_metrics()
