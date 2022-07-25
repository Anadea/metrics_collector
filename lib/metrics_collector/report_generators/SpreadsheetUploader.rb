require "google_drive"
require 'bundler'

module MetricsCollector
  class SpreadsheetUploader
    def initialize(metrics)
      @config      = ConfigObject::new
      @session     = GoogleDrive::Session.from_service_account_key(@config.google_drive_config) # TODO config
      @spreadsheet = @session.spreadsheet_by_key(@config.spreadsheet_id)
      @worksheet   = @spreadsheet.worksheets.first
      @metrics     = metrics
    end

    def update_spreadsheet
      @worksheet.insert_rows(@worksheet.num_rows + 1,
        [
          @metrics.prepend(Time.now.strftime("%d %b %Y"))
        ]
      )

      @worksheet.save
    end
  end
end
