require_relative './chess_pieces/king'
require_relative './chess_pieces/queen'
require_relative './chess_pieces/rook'
require_relative './chess_pieces/knight'
require_relative './chess_pieces/bishop'
require_relative './chess_pieces/pawn'

# Group of the chess pieces
module Piece
  King = King
  Queen = Queen
  Rook = Rook
  Knight = Knight
  Bishop = Bishop
  Pawn = Pawn
end

# An empty cell that respond true to .nil?
class EmptyCell
  attr_reader :position, :color

  def initialize(position)
    @position = position
    @color = nil
  end

  def nil?
    true
  end

  def to_s
    ' '
  end
end
