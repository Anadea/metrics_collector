require "google/apis/sheets_v4"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"

module MetricsCollector
  class SpreadsheetUploader
    SCOPE = ['https://www.googleapis.com/auth/spreadsheets',
             'https://www.googleapis.com/auth/drive']
    CREDENTIALS_PATH = 'inspired-rock-336213-161cc290d73b.json'
    SPREADSHEET = '1q-rYhDvFCRWWnHT2ZbpzzkNB6kxSaXasvjhzTm9XVI0'

    def initialize(metric_values)
      @request_body = { values: [metric_values] }
      @service = Google::Apis::SheetsV4::SheetsService.new
    end

    def call
      authorize
      upload_metrics
    end

    private

    def create_credentials
      client_secret = StringIO.new(File.read(CREDENTIALS_PATH))
      Google::Auth::ServiceAccountCredentials.make_creds(json_key_io: client_secret, scope: SCOPE )
    end

    def authorize
      credentials = create_credentials
      @service.authorization = credentials
    end
    
    def upload_metrics
      @service.append_spreadsheet_value(SPREADSHEET,'1:1', @request_body, value_input_option: 'USER_ENTERED' )
    end

    def generate_credentials

    end
  end
end
