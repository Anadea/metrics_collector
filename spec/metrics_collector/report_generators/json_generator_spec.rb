RSpec.describe JsonGenerator do
  context 'json generator' do
    let!(:metrics) { { cloc_total_files: 10, cloc_total_lines: 124 } }

    it 'file can be created with expected params' do
      allow(File).to receive(:open).with('public/metrics.json', 'w') do |file|
        expect(file).to receive(:write).with(metrics)
      end
    end

    it 'json generates with expected params' do
      buffer = StringIO.new()
      allow(File).to receive(:open).with('public/metrics.json', 'w').and_yield(buffer)
      described_class.call(metrics)
      expect(eval(buffer.string)).to eq(metrics)
    end
  end
end
