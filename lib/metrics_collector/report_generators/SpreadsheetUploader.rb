require 'bundler'

Bundler.require

class SpreadsheetUploader
  def initialize(metrics)
    @session     = GoogleDrive::Session.from_service_account_key("client_secret.json") # TODO config
    @spreadsheet = @session.spreadsheet_by_title("LeagueUp")
    @worksheet   = @spreadsheet.worksheets.first
    @metrics = metrics
    @data = [Time.now.strftime("%d/%m/%Y")] # TODO config?
    # TODO config?
    @structure = [:Brakeman_errors, :Brakeman_warnings, :Brakeman_ignored_warnings, :Coverage, :Score, :Cloc_total_files, :Cloc_total_lines]
  end

  def update_spreadsheet
    @worksheet.insert_rows(@worksheet.num_rows + 1,
      [
        structurized_data(@structure)
      ]
    )

    @worksheet.save
  end

  private

  def structurized_data(structure)
    return @data if structure.empty?

    cell = @structure.shift
    @metrics.include? cell ? @data << @metrics[cell] : @data << nil

    structurized_data(@structure)
  end
end
