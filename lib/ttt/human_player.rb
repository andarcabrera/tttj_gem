require_relative 'player'

module TTT
  class HumanPlayer < TTT::Player
    def pick_spot(board)
      spot = @input.get_spot
      until board.available_spot(spot)
        break if @input.no_more_moves_allowed?
        @input.error
        spot = @input.get_spot
      end
      spot
    end
  end
end

