module TTT
  class Game

    def initialize(players, human_move, size = 9)
      @players = players
      @human_move = human_move
      @markers = @players.map {|player| player[:marker]}
      @size = size
      @board = Board.new(@markers, size)
    end

    def game_over?
      @board.solved_board? != nil || @board.tied_board?
    end

    def make_move(spot)
      marker = @board.next_marker
      @board.fill_spot(spot, marker)
    end

    def current_state
      @board.surface
    end
  end
end
