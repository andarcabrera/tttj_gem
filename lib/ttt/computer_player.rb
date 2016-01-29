require_relative 'player'
require_relative 'computer_move'

module TTT
  class ComputerPlayer < TTT::Player

    def pick_spot(board)
      TTT::ComputerMove.select_spot(board)
    end
  end
end
