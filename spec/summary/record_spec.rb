# frozen_string_literal: true

RSpec.describe Summary::Record do
  let(:hour) { '23:51:46.691' }
  let(:turn_number) { '1' }
  let(:time) { '1:07.011' }
  let(:speed) { '41,528' }
  let(:code_and_name) { "038 – F.MASSA"}

  subject { described_class.new(hour:hour, pilot_cod_name: code_and_name, turn: turn_number, turn_time: time, turn_speed: speed) }

  before { Summary::Pilot::Repository.reset_database }

  it 'finds an existent pilot' do
    expect(Summary::Pilot).to receive(:find_by).with(code_and_name).and_call_original
    expect(subject.pilot).to_not be_nil
    expect(subject.pilot.code).to eq "038"
  end

  it 'adds a turn into pilot' do
    expect(subject.pilot.turns_count).to eq 1
  end

  it 'returns the hour' do
    expect(subject.hour).to eq hour
  end
end
