require 'game/components/pieces/childs/rook'
require 'game/components/board'

describe Rook, for: 'rook' do
  describe '#controlled_square' do
    let(:std_tb) { Board.new '8/3k4/8/1k1r2k1/8/8/3K4/8' }
    let(:corner_UL_tb) { Board.new 'r2K4/8/8/k7/8/8/8/8' }
    let(:corner_DR_tb) { Board.new '8/8/8/8/8/7K/8/5K1R' }

    it 'happy path' do
      expect([std_tb, std_tb[3, 3]])
        .to control_position([3, 2], [3, 1], [3, 4], [3, 5], [3, 6], [2, 3], [1, 3], [4, 3], [5, 3], [6, 3])
    end

    it 'corner up left' do
      expect([corner_UL_tb, corner_UL_tb[0, 0]])
        .to control_position([0, 1], [0, 2], [0, 3], [1, 0], [2, 0], [3, 0])
    end

    it 'corner down right' do
      expect([corner_DR_tb, corner_DR_tb[7, 7]])
        .to control_position([7, 6], [7, 5], [6, 7], [5, 7])
    end
  end
end
