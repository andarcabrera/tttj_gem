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

    def make_move(selected_spot)
      marker = @board.next_marker
      @board.fill_spot(selected_spot, marker)
    end

    def current_state
      @board.surface
    end

    def selected_spot
      if player_type == "human"
        @human_move.pick_spot(@board)
      elsif player_type == "computer"
        computer_move(@board)
      end
    end

    def current_player
      marker = @board.next_marker
      current_player = @players.find {|player| player[:marker] == marker}
    end

    def game_winner
      @players.find {|player| player[:marker] == @board.winning_marker}
    end

    private

    def player_type
      current_player[:type]
    end

    def computer_move
      TTT::ComputerMove(@board)
    end
  end
end
