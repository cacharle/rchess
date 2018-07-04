require 'colorize'
require_relative './pieces/index'

# the chess board
class Board
  # init the board with a grid on which the piece are placed
  def initialize(positions='rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR')
    @grid = positions.split('/').map.with_index do |row, i|
      row
        .chars.flat_map { |c| c.to_i == 0 ? c : Array.new(c.to_i) { '' } }
        .map.with_index do |p_type, j|
          color = /[A-Z]/.match(p_type).nil? ? 'black' : 'white'
          case p_type.upcase
          when 'K' then Piece::King.new [i, j], color
          when 'Q' then Piece::Queen.new [i, j], color
          when 'R' then Piece::Rook.new [i, j], color
          when 'N' then Piece::Knight.new [i, j], color
          when 'B' then Piece::Bishop.new [i, j], color
          when 'P' then Piece::Pawn.new [i, j], color
          else EmptyCell.new [i, j]
          end
        end
    end

    if (@grid[7].is_a?(NilClass) ||
        @grid[7][7].is_a?(NilClass) ||
        @grid[8].class != NilClass ||
        @grid[7][8].class != NilClass)
      raise ArgumentError, 'wrong Board init string'
    end
  end

  # cell at the position [x, y]
  def [](x, y)
    index_in_border?(x, y) ? @grid[x][y] : false
  end

  # set cell at position [x, y] to value
  def []=(x, y, value)
    @grid[x][y] = value if index_in_border?(x, y)
  end

  # get the row at the x index
  def get_row(x)
    @grid[x]
  end

  # get the column at the y index
  def get_column(y)
    @grid.transpose[y]
  end

  # get the (anti) diagonal that go through the [x, y] index
  def get_diagonal(x, y, anti: false)
    # loop backward in diagonal to find the origin
    x_stop, x_modifier = anti ? [0, -1] : [7, 1]
    until x == x_stop || y == 0
      x += x_modifier
      y -= 1
    end

    # go through the (anti) diagonal from the origin
    x_stop, x_modifier = anti ? [7, 1] : [0, -1]
    diag = [self[x, y]]
    until x == x_stop || y == 7
      x += x_modifier
      y += 1
      diag << self[x, y]
    end

    diag
  end

  ROW_SEPARATION = "   ├#{'───┼' * 7}───┤".freeze
  # string representation of the board
  def to_s
    grid_to_string = [
      "     #{('a'..'h').to_a.join('   ')}  ",
      "   ┌#{'───┬' * 7}───┐"
    ]

    @grid.each.with_index do |row, i|
      row_to_string = " #{i + 1} │"
      row.each { |cell| row_to_string << " #{cell} │" }

      grid_to_string.push(row_to_string, ROW_SEPARATION)
    end

    grid_to_string[-1] = "   └#{'───┴' * 7}───┘"
    grid_to_string.join("\n")
  end

  private

  # @returns true if the index [x, y] is in of the borders
  def index_in_border?(x, y)
    x.between?(0, 7) && y.between?(0, 7)
  end
end