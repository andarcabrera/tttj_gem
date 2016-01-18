module TTT
  class Game

    def self.game_over?(board)
      board.solved_board? != nil || board.tied_board?
    end

  end
end