require 'game/components/pieces/basic_piece'
require 'game/components/pieces/childs/king'
require 'game/components/pieces/index'
require_relative '../../../test_helper/h_board'
require_relative '../../../test_helper/h_piece'

class ECell
  def self.empty?
    true
  end
end

describe BasicPiece, for: 'basicpiece' do
  subject { BasicPiece.new [3, 3], :b }

  describe '#initialize' do
    it { expect(subject.position).to eql([3, 3]) }
    it { expect(subject.color).to eql(:b) }
  end

  describe 'private methods' do
    let(:tb) { Board.new 'k7/3k1k2/8/1k1r2k1/8/1K6/3K2K1/8' }
    subject { tb[3, 3] }
    let(:horz_sides)   { subject.send(:get_sides_of, tb, :horizontal)    }
    let(:vert_sides)   { subject.send(:get_sides_of, tb, :vertical)      }
    let(:diag_sides)   { subject.send(:get_sides_of, tb, :diagonal)      }
    let(:a_diag_sides) { subject.send(:get_sides_of, tb, :anti_diagonal) }
    let(:horz_1s_side)   { [ECell, Piece::King.new([3, 1], :b), ECell] }
    let(:horz_2n_side)   { [ECell, ECell, King.new([3, 6], :b), ECell] }
    let(:vert_1s_side)   { [ECell, King.new([1, 3], :b), ECell]        }
    let(:vert_2n_side)   { [ECell, ECell, King.new([6, 3], :w), ECell] }
    let(:diag_1s_side)   { [ECell, King.new([5, 1], :w), ECell]        }
    let(:diag_2n_side)   { [ECell, King.new([1, 5], :b), ECell]        }
    let(:a_diag_1s_side) { [ECell, ECell, King.new([0, 0], :b)]        }
    let(:a_diag_2n_side) { [ECell, ECell, King.new([6, 6], :w), ECell] }

    describe '#get_sides_of', getsides: true do
      context 'orientation = horizontal' do
        it { expect(horz_sides[0]).to equal_piece_array(horz_1s_side) }
        it { expect(horz_sides[1]).to equal_piece_array(horz_2n_side) }
      end
      context 'orientation = vertical' do
        it { expect(vert_sides[0]).to equal_piece_array(vert_1s_side) }
        it { expect(vert_sides[1]).to equal_piece_array(vert_2n_side) }
      end
      context 'orientation = diagonal' do
        it { expect(diag_sides[0]).to equal_piece_array(diag_1s_side) }
        it { expect(diag_sides[1]).to equal_piece_array(diag_2n_side) }
      end
      context 'orientation = anti_diagonal' do
        it { expect(a_diag_sides[0]).to equal_piece_array(a_diag_1s_side) }
        it { expect(a_diag_sides[1]).to equal_piece_array(a_diag_2n_side) }
      end
    end

    describe 'get_grouped_sides_of' do
      it "orientations = ['horizontal', 'vertical']" do
        expect(subject
          .send(:get_grouped_sides_of, tb, :horizontal, :vertical))
          .to contain_exactly(*horz_sides, *vert_sides)
      end
      it 'orientations = [diagonal, anti_diagonal]' do
        expect(subject
          .send(:get_grouped_sides_of, tb, :diagonal, :anti_diagonal))
          .to contain_exactly(*diag_sides, *a_diag_sides)
      end
      it 'orientations = [vertical, horizontal, diagonal, anti_diagonal]' do
        expect(subject
          .send(:get_grouped_sides_of, tb,
                :vertical, :horizontal, :diagonal, :anti_diagonal))
          .to contain_exactly(*horz_sides, *vert_sides, *diag_sides, *a_diag_sides)
      end
    end

    describe '#filter_side' do
      let(:flt_horz_1s_side)   { subject.send(:filter_side, horz_1s_side) }
      let(:flt_vert_2n_side)   { subject.send(:filter_side, vert_2n_side) }
      let(:flt_diag_1s_side)   { subject.send(:filter_side, diag_1s_side) }
      let(:flt_a_diag_2n_side) { subject.send(:filter_side, a_diag_2n_side) }
      it('left side') { expect(flt_horz_1s_side).to equal_piece_array([ECell]) }
      it('up side') { expect(flt_vert_2n_side).to equal_piece_array([ECell, ECell]) }
      it 'diagonal down side' do
        expect(flt_diag_1s_side).to equal_piece_array([ECell, King.new([5, 1], :w)])
      end
      it'anti diagonal down side' do
        expect(flt_a_diag_2n_side).to equal_piece_array([ECell, ECell, King.new([6, 6], :w)])
      end
    end

    describe '#valid_cell?' do
      context 'the cell is empty or enemy color' do
        it { expect(subject.send(:valid_cell?, King.new([0, 0], :w))).to be true }
        it { expect(subject.send(:valid_cell?, EmptyCell.new([0, 0]))).to be true }
      end
      context 'the cell is the same color or false' do
        it { expect(subject.send(:valid_cell?, King.new([0, 0], :b))).to be false }
        it { expect(subject.send(:valid_cell?, false)).to be nil }
      end
    end

    describe '#get_cell_type' do
      it { expect(subject.send(:get_cell_type, EmptyCell.new([0, 0]))).to be :empty }
      it { expect(subject.send(:get_cell_type, BasicPiece.new([0, 0], :b))).to be :ally }
      it { expect(subject.send(:get_cell_type, BasicPiece.new([0, 0], :w))).to be :enemy }
    end
  end
end
