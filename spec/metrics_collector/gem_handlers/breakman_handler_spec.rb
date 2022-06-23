RSpec.describe BrakemanHandler do
  context 'breakman handler' do
    let!(:metrics) { {} }
    let!(:brakeman_report) { File.read('spec/helpers/brakeman_report.json') }

    it 'collects metrics' do
      allow(BrakemanHandler).to receive(:run_brakeman).and_return(nil)
      allow(File).to receive(:exist?).with('public/brakeman.json').and_return(true)
      allow(File).to receive(:read).and_return(brakeman_report)

      described_class.call(metrics)
      expect(metrics).to eq({ Brakeman_errors: nil, Brakeman_warnings: 4, Brakeman_ignored_warnings: nil })
    end
  end
end
