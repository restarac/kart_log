# frozen_string_literal: true

RSpec.describe Summary::Parser, '.from_file' do
  subject { described_class }

  let(:only_header_input) { "spec/fixture/parser_spec/only_header_input.log" }
  let(:one_pilote_input) { "spec/fixture/parser_spec/one_pilot_input.log" }

  it 'skips the header' do
    archive = subject.from_file(only_header_input)
    expect(archive.values).to be_empty
  end

  it 'load the data from a file' do
    archive = subject.from_file(one_pilote_input)
    expect(archive.values.first).to_not be_nil
  end

  context 'when has tabs' do
    let(:data_with_tabs_input) { "spec/fixture/parser_spec/data_with_tabs_input.log" }

    it 'load the data from a file' do
      archive = subject.from_file(data_with_tabs_input)
      expect(archive.values.first).to_not be_nil
    end
  end
end
