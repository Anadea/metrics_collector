# frozen_string_literal: true

RSpec.describe RubycriticHandler do
  context 'rubycritic handler' do
    let!(:metrics) { {} }
    let!(:rubycritic_report) { File.read('spec/helpers/rubycritic_report.json') }

    it 'collects metrics' do
      allow(RubycriticHandler).to receive(:run_rubycritic).and_return(true)
      allow(File).to receive(:exist?).with('tmp/rubycritic/report.json').and_return(true)
      allow(File).to receive(:read).and_return(rubycritic_report)

      described_class.call(metrics)
      expect(metrics).to eq({ Rubycritic_score: 66.81 })
    end
  end
end
