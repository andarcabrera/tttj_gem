module TTT
  class Game

    def initialize(db, players, size = 9)
      @db = db
      @players = players
      @markers = @players.map {|player| player.marker}
      @size = size
      @board = Board.new(@markers, size)
    end

    def game_over?
      @board.solved_board? != nil || @board.tied_board?
    end

    def make_move
      marker = @board.next_marker
      spot = current_player.pick_spot(@board)
      @board.fill_spot(spot, marker) if spot != "break loop"
      if game_over?
        @db.save_game(current_state, @markers)
      end
      spot
    end

    def manually_update_board(spot, marker)
      @board.fill_spot(spot, marker)
    end

    def current_state
      @board.surface
    end

    def current_player
      marker = @board.next_marker
      current_player = @players.find {|player| player.marker == marker}
    end

    def previous_player
      marker = @board.next_marker
      previous_player = @players.find {|player| player.marker != marker}
    end

    def game_winner
      @players.find {|player| player.marker == @board.winning_marker}
    end

    def markers
      @markers
    end

  end
end

