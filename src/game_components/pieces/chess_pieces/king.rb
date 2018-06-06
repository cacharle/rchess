require_relative '../basic_piece'

# class of a Rook
class King < BasicPiece
  def initialize(position, color)
    super(position, color)
    @first_move = true
  end

  def to_s
    @color == 'white' ? '♔' : '♚'
  end

  def get_possible_moves(board)
    ([-1, 1, 0].product([-1, 1, 0]) - [[0, 0]])
      .map { |mod| [@position[0] + mod[0], @position[1] + mod[1]] }
      .select { |pos| valid_cell?(board[*pos]) }
  end
end
