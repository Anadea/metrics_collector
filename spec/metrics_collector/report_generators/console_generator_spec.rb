RSpec.describe ConsoleGenerator do
  context 'console generator' do
    let!(:metrics) { { cloc_total_files: 10, cloc_total_lines: 124 } }

    it 'console output works as expected' do
      expect { described_class.call(metrics) }.to output("cloc_total_files: 10\ncloc_total_lines: 124\n").to_stdout
    end
  end
end
