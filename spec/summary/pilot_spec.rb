# frozen_string_literal: true

RSpec.describe Summary::Pilot do
  let(:code_and_name) { "#{code} – #{name}"}
  let(:code) { '038' }
  let(:name) { 'F.MASSA' }

  describe '.find_by' do
    subject { described_class }
    before { Summary::Pilot::Repository.reset_database }

    it 'creates a new pilot object' do
      result = subject.find_by code_and_name

      expect(result.code).to eq code
      expect(result.name).to eq name
    end

    context 'when has created' do
      it 'retrives the same instance' do
        result1 = subject.find_by code_and_name
        result2 = subject.find_by code_and_name

        expect(result1).to eq result2
      end
    end
  end

  describe '#average_speed' do
    subject { described_class.new code, name }

    it 'returns the average speed' do
      subject.add_turn number: '1', time: '1:07.011', speed: '50,528'
      subject.add_turn number: '2', time: '1:07.011', speed: '20,528'

      expect(subject.average_speed).to eq((50.528 + 20.528)/2)
    end

    context 'when has one turn' do
      it 'returns the average speed oh that turn' do
        subject.add_turn number: '1', time: '1:07.011', speed: '50,528'

        expect(subject.average_speed).to eq 50.528
      end
    end

    context 'when hasn\'t turn' do
      it 'returns the average speed oh that turn' do
        expect(subject.average_speed).to eq 0
      end
    end
  end

  describe '#time_total' do
    subject { described_class.new code, name }

    it 'returns the time total in milliseconds' do
      subject.add_turn number: '1', time: '1:07.011', speed: '41,528'

      expect(subject.time_total).to eq 67011
    end

    context 'when time has only milliseconds' do
      it 'returns in milliseconds' do
        subject.add_turn number: '1', time: '0:00.011', speed: '41,528'

        expect(subject.time_total).to eq 11
      end
    end

    context 'when time has only seconds' do
      it 'returns in milliseconds' do
        subject.add_turn number: '1', time: '0:30.000', speed: '41,528'

        expect(subject.time_total).to eq 30000
      end
    end

    context 'when time has only minutes' do
      it 'returns in milliseconds' do
        subject.add_turn number: '1', time: '5:00.000', speed: '41,528'

        expect(subject.time_total).to eq 300000
      end
    end
  end
end
