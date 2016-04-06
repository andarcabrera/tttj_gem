require 'tttj/player'
require 'tttj/computer_move'

module TTT
  class ComputerPlayer < TTT::Player

    def pick_spot(board)
      TTT::ComputerMove.computer_move(board)
    end
  end
end
