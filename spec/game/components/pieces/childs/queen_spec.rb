require 'game/components/pieces/childs/queen.rb'
require 'game/components/board'
require_relative '../../../../test_helper/h_piece'

describe Queen, for: 'queen' do
  describe '#controlled_square' do
    let(:std_tb) { Board.new '8/1k1k1k2/8/1k1q2k1/8/1K6/3K2K1/8' }
    let(:corner_DL_tb) { Board.new '8/8/8/4k3/8/K7/8/Q1K5' }
    let(:corner_UR_tb) { Board.new '4k2q/8/8/4k2k/8/8/8/8' }
    let(:corner_UL_tb) { Board.new 'q1k5/8/k7/3k4/8/8/8/8' }
    let(:corner_DR_tb) { Board.new '8/8/8/3k4/8/7K/8/4K2Q' }

    it 'happy path' do
      expect([std_tb, std_tb[3, 3]])
        .to control_position(
          [3, 2], [3, 1], [3, 4], [3, 5], [3, 6], [2, 3], [1, 3], [2, 2], [1, 1], [4, 4],
          [4, 3], [5, 3], [6, 3], [4, 2], [5, 1], [2, 4], [1, 5], [5, 5], [6, 6]
        )
    end

    it 'corner up left' do
      expect([corner_UL_tb, corner_UL_tb[0, 0]])
        .to control_position([0, 1], [0, 2], [1, 0], [2, 0], [1, 1], [2, 2], [3, 3])
    end

    it 'corner up right' do
      expect([corner_UR_tb, corner_UR_tb[0, 7]])
        .to control_position([0, 6], [0, 5], [0, 4], [1, 7], [2, 7], [3, 7], [1, 6], [2, 5], [3, 4])
    end

    it 'corner down left' do
      expect([corner_DL_tb, corner_DL_tb[7, 0]])
        .to control_position([7, 1], [7, 2], [6, 0], [5, 0], [6, 1], [5, 2], [4, 3], [3, 4])
    end

    it 'corner down right' do
      expect([corner_DR_tb, corner_DR_tb[7, 7]])
        .to control_position([7, 6], [7, 5], [7, 4], [6, 7], [5, 7], [6, 6], [5, 5], [4, 4], [3, 3])
    end
  end
end
