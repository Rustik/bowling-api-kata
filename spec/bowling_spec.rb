require_relative './helper'

RSpec.describe Bowling do
  let(:game_id) { 1 }
  let(:game) { Bowling.new(game_id) }

  before do
    REDIS.flushall
    pins.each { |pin| game.roll!(pin) }
  end

  subject { game.frames_score }

  context 'when all gutter game' do
    let(:pins) { [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] } # 20 rolls
    it { is_expected.to eq([0, 0, 0, 0, 0, 0, 0, 0, 0, 0]) } # 10 zero scored frames
  end

  context 'when all ones game' do
    let(:pins) { [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1] }
    it { is_expected.to eq([2, 2, 2, 2, 2, 2, 2, 2, 2, 2]) }
  end

  context 'when all fifth game' do
    let(:pins) { [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5] } # 20 + extra roll for spare
    it { is_expected.to eq([15, 15, 15, 15, 15, 15, 15, 15, 15, 15]) } # total of 150
  end

  context 'when perfect game' do
    let(:pins) { [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10] } # 20 + extra roll for spare
    it { is_expected.to eq([30, 30, 30, 30, 30, 30, 30, 30, 30, 30]) } # total of 300
  end

  context 'with strike' do
    let(:pins) { [10, 7, 1] }
    it { is_expected.to eq([18, 8, 0, 0, 0, 0, 0, 0, 0, 0]) }
  end

  context 'with spare' do
    let(:pins) { [3, 7, 1, 8] }
    it { is_expected.to eq([11, 9, 0, 0, 0, 0, 0, 0, 0, 0]) }
  end

end