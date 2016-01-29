require_relative 'player'

module TTT
  class HumanPlayer < TTT::Player
    def pick_spot(board)
      spot = @input.get_spot
      until board.available_spot?(spot)
        @input.error
        spot = @input.get_spot
        p spot
      end
      spot
    end
  end
end

