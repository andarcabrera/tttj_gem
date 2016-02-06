module TTT
  class Board

    attr_accessor :size, :markers, :surface

    def initialize(markers = [], size = 9)
      @size = size
      @surface = (0..size-1).map{|el| el.to_s}
      @markers = markers
    end

    def available_spot?(spot)
      surface.include?(spot.to_s)
    end

    def available_spots
      surface.select {|spot| !markers.include?(spot)}
    end

    def fill_spot(spot, marker)
      surface[spot.to_i] = marker
    end

    def solved_board?
      !check_board.nil?
    end

    def tied_board?
      surface.all? { |spot| markers.include?(spot)} && !solved_board?
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

    def winning_marker
      check_board[0]
    end

    private

    def check_board
      check_rows || check_columns|| check_diagonals
    end

    def check_rows
      partioned_board.find(&winning_combination)
    end

    def check_columns
      partioned_board.transpose.find(&winning_combination)
    end

    def check_diagonals
      diagonals = [left_diagonal, right_diagonal]
      diagonals.find(&winning_combination)
    end

    def left_diagonal
      partioned_board.map.with_index {|row, index| row[index]}
    end

    def right_diagonal
      partioned_board.map.with_index {|row, index| row[(index-(row.length - 1)).abs]}
    end

    def winning_combination
      Proc.new {|row| row.uniq.length == 1 }
    end

    def partioned_board
      splitter = Math.sqrt(surface.length).to_i
      surface.each_slice(splitter).to_a
    end
  end
end
