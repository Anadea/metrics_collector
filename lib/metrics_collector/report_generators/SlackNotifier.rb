require 'net/http'
require 'uri'

class SlackNotifier
	def initialize(channels, token, outputs, metrics, paths)
		@channels = channels
		@token    = token
		@outputs  = outputs
		@metrics  = metrics
		@paths    = paths
		@headers  = {
			'Accept' 			  => 'multipart/form-data',
			'Content-Type'  => 'multipart/form-data',
			'Authorization' => "Bearer #{@token}"
		}
	end

	def call
		return if @channels.nil? && @token.nil?


		send_message      if @outputs.include? 'console'
		send_file(@paths['json']) if @outputs.include? 'json'
		send_file(@paths['csv'])  if @outputs.include? 'csv'
	end

	private

	def send_file(path)
		files_endpoint = 'https://slack.com/api/files.upload'
		form_data = [
			['file', File.open("public/#{path}")],
			['channels', @channels.join(', ')]
		]

		send_request(files_endpoint, form_data)
	end

	def send_message
		messages_endpoint = 'https://slack.com/api/chat.postMessage'

		@channels.each do |channel|
			form_data = {
				'channel' => channel,
				'text'    => @metrics.map{|metric, value| "#{metric.to_s.humanize}: #{value}"}.join("\n")
			}

			send_request(messages_endpoint, form_data)
		end
	end

	def send_request(endpoint, payload)
		uri = URI.parse(endpoint)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		request = Net::HTTP::Post.new(uri.request_uri, @headers)
		request.set_form payload, 'multipart/form-data'
		http.request(request)
	end
end
