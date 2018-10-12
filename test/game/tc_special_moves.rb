require 'game/index'
require 'game/special_moves'
require 'game/components/pieces/index'

class Game; attr_accessor :history; end


describe VerifySpecialMoves, for: 'special_moves' do
  describe '#can_pawn_promotion?' do
    let(:no_promo_g) { Game.new Board.new '8/8/8/3k4/8/8/8/8' }
    it { expect(no_promo_g.can_pawn_promotion?).to be false }
    let(:promo_white_g) { Game.new Board.new '3P4/8/8/8/8/8/8/8' }
    it { expect(promo_white_g.can_pawn_promotion?).to eql([0, 3]) }
    let(:promo_black_g) { Game.new Board.new '8/8/8/8/8/8/8/3p4' }
    it { expect(promo_black_g.can_pawn_promotion?).to eql([7, 3]) }
  end

  describe '#can_castle?' do
    let(:in_check_white_g) { Game.new Board.new '8/8/8/8/4q3/8/8/R3K2R' }
    let(:in_check_black_g) { Game.new Board.new 'r3k2r/8/8/4Q3/8/8/8/8' }
    let(:cast_controlled_white_g) { Game.new Board.new '' }
    let(:cast_controlled_black_g) { Game.new Board.new 'r3k2r/8/6N1/5B2/8/8/8/8' }
    let(:piece_between_white_g) { Game.new Board.new '8/8/8/8/8/8/8/RN2KB1R' }
    let(:piece_between_black_g) { Game.new Board.new 'r2qk1nr/8/8/8/8/8/8/8' }
    let(:king_moved_white_g) { Game.new Board.new '8/8/8/8/8/8/8/R3K2R' }
    let(:king_moved_black_g) { Game.new Board.new 'r3k2r/8/8/8/8/8/8/8' }
    let(:king_rook_moved_white_g) { Game.new Board.new '8/8/8/8/8/8/8/R3K2R' }
    let(:queen_rook_moved_white_g) { Game.new Board.new '8/8/8/8/8/8/8/R3K2R' }
    let(:king_rook_moved_black_g) { Game.new Board.new 'r3k2r/8/8/8/8/8/8/8' }
    let(:queen_rook_moved_black_g) { Game.new Board.new 'r3k2r/8/8/8/8/8/8/8' }
    let(:right_condition_white_g) { Game.new Board.new '8/8/8/8/8/8/8/R3K2R' }
    let(:right_condition_black_g) { Game.new Board.new 'r3k2r/8/8/8/8/8/8/8' }

    let(:no_castle) { {king_side: false, queen_side: false} }


    it 'false if king in check' do
      expect(in_check_white_g.can_castle?(:w)).to eq no_castle
      expect(in_check_black_g.can_castle?(:b)).to eq no_castle
    end
    it 'false if castling square are controlled by the enemy' do
      ###############################
      # ne fonctionne pas avec un pion a cause de mon système de coup possible
      # penser a comment le transformer en case controllé par piece et déduire si un coup est possible
      # en fonction de ce qui ce trouve sur la case coutrollé selectionné
      # -> retirer le filtrage des allié dans le corp des pieces
      ###############################
    end

    it 'false if piece between the king and rook' do
      expect(piece_between_white_g.can_castle?(:w)).to eq no_castle
      expect(piece_between_black_g.can_castle?(:b)).to eq no_castle
    end

    it 'false if king as moved before' do
      king_moved_white_g.history.add_entry({piece: Piece::init(:K, [7, 4]), from: [6, 4], to: [7, 4]})
      king_moved_black_g.history.add_entry({piece: Piece::init(:k, [0, 4]), from: [1, 4], to: [0, 4]})
      expect(king_moved_white_g.can_castle?(:w)).to eq no_castle
      expect(king_moved_black_g.can_castle?(:b)).to eq no_castle
    end

    it 'false king_side if king rook as moved before' do
      king_rook_moved_white_g.history.add_entry({piece: Piece::init(:R, [6, 7]), from: [7, 7], to: [6, 7]})
      king_rook_moved_black_g.history.add_entry({piece: Piece::init(:r, [1, 7]), from: [0, 7], to: [1, 7]})
      expect(king_rook_moved_white_g.can_castle?(:w)).to eq({king_side: false, queen_side: true})
      expect(king_rook_moved_black_g.can_castle?(:b)).to eq({king_side: false, queen_side: true})
    end
    
    it 'false queen_side if queen rook as moved before' do
      queen_rook_moved_white_g.history.add_entry({piece: Piece::init(:R, [6, 0]), from: [7, 0], to: [6, 0]})
      queen_rook_moved_black_g.history.add_entry({piece: Piece::init(:r, [1, 0]), from: [0, 0], to: [1, 0]})
      expect(queen_rook_moved_white_g.can_castle?(:w)).to eq({king_side: true, queen_side: false})
      expect(queen_rook_moved_black_g.can_castle?(:b)).to eq({king_side: true, queen_side: false})
    end

    it 'true if all condition are right' do
    end
  end

  describe '#can_en_passant?' do

  end
end

describe ExecuteSpecialMoves do
  describe '#exec_pawn_promotion' do
    
  end

  describe '#exec_castle' do
    
  end

  describe '#exec_en_passant' do
    
  end
end