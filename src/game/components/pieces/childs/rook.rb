require_relative '../basic_piece'

# class of a Rook
class Rook < BasicPiece
  def to_s
    @color == :w ? '♖' : '♜'
  end

  # @returns the list of position where the rook can move
  def controlled_squares(board)
    get_grouped_sides_of(board, :horizontal, :vertical)
      .flat_map { |side| filter_accessibility(side) }
      .map(&:position)
  end
end
