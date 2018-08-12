# frozen_string_literal: true

RSpec.describe Summary::Ranking do
  let(:pilot) { Summary::Pilot.new "043", "Facebook" }
  let(:pilot_unfinished) { Summary::Pilot.new "019", "Google" }

  subject { described_class}

  before do
    pilot.add_turn number: '1', time: '1:07.011', speed: '50,528'
  end

  it 'removes unfinished pilots' do
    expect(subject.new([pilot_unfinished]).pilots).to eq []
  end

  describe '#show' do
    it 'returns a message when hasn\'t pilots' do
      expect(subject.new([]).show).to eq "No pilots have finished yet"
    end

    it 'shows only finished pilots' do
      expeced_result =
<<-STRING
Position;Pilot;Time Total;Average Speed
1;043 - Facebook;67011;50.528
STRING
      expect(subject.new([pilot], threshold_turn: 1).show).to eq expeced_result.chomp
    end

    context 'Order when has more than one' do
      let(:pilot2) { Summary::Pilot.new "028", "Microsoft" }
      let(:pilot3) { Summary::Pilot.new "029", "2K Games" }

      before do
        pilot2.add_turn number: '1', time: '1:03.536', speed: '39,278'
        pilot3.add_turn number: '1', time: '1:06.858', speed: '42,578'
      end

      it 'orders by time total DESC' do
        expeced_result =
<<-STRING
Position;Pilot;Time Total;Average Speed
1;028 - Microsoft;63536;39.278
2;029 - 2K Games;66858;42.578
3;043 - Facebook;67011;50.528
STRING
        expect(subject.new([pilot, pilot2, pilot3], threshold_turn: 1).show).to eq expeced_result.chomp
      end
    end


  end
end
