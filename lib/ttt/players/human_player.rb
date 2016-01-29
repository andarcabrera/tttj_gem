require_relative 'player'

module TTT
  class HumanPlayer < TTT::Player
    def pick_spot(board)
      spot = @input.get_spot
      if board.available_spot?(spot)
        spot
      else
        raise @input.error
      end
    end
  end
end


