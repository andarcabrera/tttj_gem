require_relative 'player'

class HumanPlayer < Player

  def pick_spot(board, user_input)
    if board.available_spot(user_input)
      user_input
    end
  end
end
