# frozen_string_literal: true

RSpec.describe CsvGenerator do
  context 'csv generator' do
    subject(:csv_file) { described_class.call(metrics) }
    let!(:metrics) { { breakman_warnings: 4, cloc_total_files: 10, cloc_total_lines: 124 } }

    it 'generates csv' do
      buffer = StringIO.new
      allow(File).to receive(:open).and_return(buffer)

      csv_file

      generated_csv = CSV.generate_line([
        CSV.generate do 
          |csv| csv_file.to_a.each { |generated_metric| csv << generated_metric }
        end 
      ])

      expected_csv = CSV.generate_line([
        CSV.generate do 
          |csv| metrics.to_a.each { |metric| csv << metric }
        end 
       ])

       expect(generated_csv).to eq(expected_csv)
    end
  end
end
