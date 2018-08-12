# frozen_string_literal: true

RSpec.describe Summary::Turn do
  let!(:cod) { '1' }
  let(:time) { '1:07.011' }
  let(:speed) { '41,528' }

  subject { described_class.new(cod: cod, time: time, speed: speed) }

  it 'splits the time into minute, second and millisecond' do
    expect(subject.minute).to eq 1
    expect(subject.second).to eq 7
    expect(subject.millisecond).to eq 11
  end

  it 'convert speed into float' do
    expect(subject.speed).to be_instance_of Float
    expect(subject.speed).to eq 41.528
  end

  it 'convert cod into integer' do
    expect(subject.cod).to be_instance_of Integer
    expect(subject.cod).to eq 1
  end
end
