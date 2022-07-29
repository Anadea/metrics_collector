require "google/apis/sheets_v4"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"

module MetricsCollector
  class SpreadsheetUploader
    SCOPE = ['https://www.googleapis.com/auth/spreadsheets',
             'https://www.googleapis.com/auth/drive']

    def initialize(metric_values, spreadsheet, credentials)
      @request_body  = { values: [metric_values] }
      @service       = Google::Apis::SheetsV4::SheetsService.new
      @spreadsheet   = spreadsheet(spreadsheet)
      @client_secret = client_secret(credentials)
    end

    def call
      return if @client_secret.string == 'null'

      authorize
      upload_metrics
    end

    private

    def create_credentials
      Google::Auth::ServiceAccountCredentials.make_creds(json_key_io: @client_secret, scope: SCOPE )
    end

    def authorize
      @service.authorization = create_credentials
    end
    
    def upload_metrics
      @service.append_spreadsheet_value(@spreadsheet,'1:1', @request_body, value_input_option: 'USER_ENTERED' )
    end

    def client_secret(credentials)
      return format_credentials(credentials) unless credentials.nil?

      StringIO.new(MetricsCollector::CONFIG.google_client_secret.to_json)
    end

    def spreadsheet(spreadsheet)
      return spreadsheet unless spreadsheet.nil?

      MetricsCollector::CONFIG.google_spreadsheet_id
    end

    def format_credentials(credentials)
      credentials['private_key'] = credentials['private_key'].gsub("\\n", "\n") if credentials['private_key']

      StringIO.new(credentials.to_json)
    end
  end
end
