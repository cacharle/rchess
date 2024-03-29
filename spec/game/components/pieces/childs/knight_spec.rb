require 'game/components/pieces/childs/knight.rb'
require 'game/components/board'
require_relative '../../../../test_helper/h_piece'

describe Knight, for: 'knight' do
  describe '#controlled_square' do
    let(:std_tb) { Board.new '8/4k3/1k3K2/3n4/5k2/8/8/8' }
    let(:corner_UL_tb) { Board.new 'n7/8/1k6/8/8/8/8/8' }
    let(:corner_DR_tb) { Board.new '8/8/8/8/8/6K1/8/7N' }

    it 'happy path' do
      expect([std_tb, std_tb[3, 3]])
        .to control_position([2, 1], [2, 5], [4, 1], [4, 5], [1, 2], [1, 4], [5, 2], [5, 4])
    end

    specify do
      expect { corner_UL_tb[0, 0].controlled_square(corner_UL_tb) }.not_to raise_error
    end
    it 'corner up left' do
      expect([corner_UL_tb, corner_UL_tb[0, 0]]).to control_position([1, 2], [2, 1])
    end

    specify do
      expect { corner_DR_tb[7, 7].controlled_square(corner_DR_tb) }.not_to raise_error
    end
    it 'corner down right, shouldnt fail' do
      expect([corner_DR_tb, corner_DR_tb[7, 7]]).to control_position([6, 5], [5, 6])
    end
  end
end
