#TTT::Board
# module TTT
class Board1

  def initialize(markers = [], size = 9)
    @size = size
    @surface = (0..size-1).map{|el| el.to_s}
    @markers = markers
  end

  def available_spot(spot)
    !markers.include?(surface[spot.to_i])
  end

  def available_spots
    surface.select {|spot| !markers.include?(spot)}
  end

  def fill_spot(spot, marker)
    surface[spot.to_i] = marker
  end

  def solved_board?
    row_solved? || column_solved? || diagonals_solved?
  end

  def tied_board?
   surface.find { |spot| !markers.include?(spot)} == nil && !solved_board?
  end

  def next_marker
    if size.odd?
     if available_spots.count.even?
        markers[1]
      else
        markers[0]
      end
    else
      if available_spots.count.even?
        markers[0]
      else
        markers[1]
      end
    end
  end

  def set_markers(markers)
    @markers = markers
  end

  def markers
    @markers
  end

  def surface
    @surface
  end

  def set_surface(surface)
    @surface = surface
  end

  def size
    @size
  end

  def set_size(size)
    @size = size
  end

  private

  def row_solved?
    partioned_board.find {|row| row.uniq.length == 1}
  end

  def column_solved?
    partioned_board.transpose.find {|row| row.uniq.length == 1}
  end

  def diagonals_solved?
    diagonals = [left_diagonal, right_diagonal]
    diagonals.find {|row| row.uniq.length == 1}
  end

  def left_diagonal
    diagonal = []
    partioned_board.select.with_index {|row, index| diagonal << row[index]}
    diagonal
  end

  def right_diagonal
    diagonal = []
    partioned_board.select.with_index {|row, index| diagonal << row[(index-(row.length - 1)).abs]}
    diagonal
  end

  def partioned_board
    splitter = Math.sqrt(surface.length).to_i
    surface.each_slice(splitter).to_a
  end

end
# end
