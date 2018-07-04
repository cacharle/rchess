require_relative './childs/king'
require_relative './childs/queen'
require_relative './childs/rook'
require_relative './childs/knight'
require_relative './childs/bishop'
require_relative './childs/pawn'

# Group of the chess pieces
module Piece
  King = King
  Queen = Queen
  Rook = Rook
  Knight = Knight
  Bishop = Bishop
  Pawn = Pawn
end

# An empty cell that respond true to empty?
class EmptyCell
  attr_reader :position, :color

  def initialize(position)
    @position = position
    @color = nil
  end

  def empty?
    true
  end

  def to_s
    ' '
  end
end