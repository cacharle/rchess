require_relative '../basic_piece'
require_relative '../../../../helper.rb'

# class of a Rook
class King < BasicPiece
  def to_s
    @color == :w ? '♔' : '♚'
  end

  # position list of the controlled square
  # surrounding in a range of 1
  def controlled_square(_)
    ([-1, 1, 0].product([-1, 1, 0]) - [[0, 0]])
      .map { |mod| [@position[0] + mod[0], @position[1] + mod[1]] }
      .select { |i| Helper::in_border?(*i) }
  end
end
