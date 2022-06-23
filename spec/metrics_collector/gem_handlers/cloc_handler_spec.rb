# frozen_string_literal: true

RSpec.describe ClocHandler do
  context 'cloc handler' do
    let!(:metrics) { {} }
    let!(:cloc_report) { File.read('spec/helpers/cloc_report.json') }

    it 'collects metrics' do
      allow(ClocHandler).to receive(:check_availability).and_return(true)
      allow(ClocHandler).to receive(:run_cloc).and_return(true)
      allow(File).to receive(:exist?).with('stats.json').and_return(true)
      allow(File).to receive(:read).and_return(cloc_report)

      described_class.call(metrics)
      expect(metrics).to eq({ Cloc_total_lines: 455_292, Cloc_total_files: 1859 })
    end
  end
end
