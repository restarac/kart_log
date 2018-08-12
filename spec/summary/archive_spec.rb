# frozen_string_literal: true

RSpec.describe Summary::Archive do
  subject { described_class.new }

  describe '#add' do
    let(:hour) { '23:51:46.691' }
    let(:turn_number) { '1' }
    let(:time) { '1:07.011' }
    let(:speed) { '41,528' }
    let(:code_and_name) { "038 – F.MASSA"}

    let(:record) { Summary::Record.new(hour:hour, pilot_cod_name: code_and_name, turn: turn_number, turn_time: time, turn_speed: speed) }

    it 'adds the record' do
      expect { subject.add record }.to change{subject.records.size}.by(1)
    end

    it 'adds the pilot' do
      expect { subject.add record }.to change{subject.pilots.size}.by(1)
    end

    context 'when adds the same record' do

      it 'does not change the pilots' do
        subject.add record

        expect { subject.add record }.to_not change{subject.pilots.size}
      end
    end
  end
end
