require 'tttj/player'

module TTT
  class HumanPlayer < TTT::Player
    def pick_spot(board)
      spot = @ui.get_spot
      until board.available_spot?(spot)
        spot = nil
        break if @ui.no_more_moves_allowed?
        @ui.error
        spot = @ui.get_spot
      end
      spot
    end
  end
end

