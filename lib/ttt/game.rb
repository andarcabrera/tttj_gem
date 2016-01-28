module TTT
  class Game

    def initialize(db, players, human_move, size = 9)
      @db = db
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
      if game_over?
        @db.save_game(current_state, @markers)
      end
    end

    def manually_update_board(spot, marker)
      @board.fill_spot(spot, marker)
    end

    def current_state
      @board.surface
    end

    def selected_spot(spot = nil)
      if player_type == "human"
        @human_move.pick_spot(@board, spot)
      elsif player_type == "computer"
        computer_move
      end
    end

    def current_player
      marker = @board.next_marker
      current_player = @players.find {|player| player[:marker] == marker}
    end

    def previous_player
      marker = @board.next_marker
      previous_player = @players.find {|player| player[:marker] != marker}
    end

    def game_winner
      @players.find {|player| player[:marker] == @board.winning_marker}
    end

    def markers
      @markers
    end

    private

    def player_type
      current_player[:type]
    end

    def computer_move
      TTT::ComputerMove.computer_move(@board)
    end
  end
end
