require_relative './pieces/pieces'


# the chess board
class Board

  ROW_SEPARATION = "   ├#{'───┼' * 7}───┤"

  attr_accessor :grid

  # init the board with a grid on wich the piece will be placed
  def initialize(
    kingPositions: [[0, 4], [7, 4]],
    queenPositions: [[0, 3], [7, 3]],
    rookPositions: [[0, 0], [0, 7], [7, 0], [7, 7]],
    knightPositions: [[0, 1], [0, 6], [7, 1], [7, 6]],
    bishopPositions: [[0, 2], [0, 5], [7, 2], [7, 5]],
    pawnPositions: [1, 6].product((0..7).to_a)
  )
    @grid = Array.new(8) { Array.new 8 }

    @grid.map!.with_index do |row, i|
      row.map!.with_index do |_, j|
        color = i < 5 ? 'black' : 'white'

        case [i, j]
          when *kingPositions   then Piece::King.new [i, j], color
          when *queenPositions  then Piece::Queen.new [i, j], color
          when *rookPositions   then Piece::Rook.new [i, j], color
          when *knightPositions then Piece::Knight.new [i, j], color
          when *bishopPositions then Piece::Bishop.new [i, j], color
          when *pawnPositions   then Piece::Pawn.new [i, j], color
          else EmptyCell.new [i, j]
        end
      end
    end
  end

  # @returns false if the index is out of border,
  #          the cell at the position [x, y] otherwise.
  def [](x, y)
    return false if indexIsOutBorder?(x, y)
    @grid[x][y]
  end

  # set the cell at position [x, y] to value
  def []=(x, y, value)
    @grid[x][y] = value unless indexIsOutBorder?(x, y)
  end

  # @returns the row at the x index
  def getRow(index)
    @grid[index]
  end
  
  # @returns the column at the y index
  def getColumn(index)
    @grid.transpose[index]
  end

  # string representation of the board
  def to_s
    grid_to_string = [
      "     #{('a'..'h').to_a.join('   ')}",
      "   ┌#{'───┬' * 7}───┐"
    ]

    @grid.each.with_index do |row, i|
      row_to_string = " #{i + 1} │"

      row.each.with_index do |cell, j|
        row_to_string << " #{cell.nil? ? ' ' : cell} │"
      end

      grid_to_string.push(
        row_to_string,
        i == 7 ? "   └#{'───┴' * 7}───┘" : ROW_SEPARATION
      )
    end

    grid_to_string.join("\n")
  end


  private

  # @returns true if the index [x, y] is out of the borders
  def indexIsOutBorder?(x, y)
    return true if x < 0 || x > 7 || y < 0 || y > 7
    false
  end
end
