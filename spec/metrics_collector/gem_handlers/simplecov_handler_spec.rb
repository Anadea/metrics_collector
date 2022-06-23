# frozen_string_literal: true

RSpec.describe SimplecovHandler do
  context 'simplecov handler' do
    let!(:metrics) { {} }
    let!(:simplecov_report) { File.read('spec/helpers/simplecov_report.json') }

    it 'collects metrics' do
      allow(File).to receive(:exist?).with('public/coverage/.last_run.json').and_return(true)
      allow(File).to receive(:read).and_return(simplecov_report)

      described_class.call(metrics)
      expect(metrics).to eq({ Coverage: 9.4 })
    end
  end
end
