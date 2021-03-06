require_relative 'board'

module TTT
  class Game

    attr_reader :markers, :size

    def initialize(players, size = 9)
      @players = players
      @markers = @players.map {|player| player.marker}
      @size = size.to_i
      @board = TTT::Board.new(@markers, @size)
    end

    def game_over?
      @board.solved_board? || @board.tied_board?
    end

    def make_move
      marker = @board.next_marker
      spot = current_player.pick_spot(@board)
      @board.fill_spot(spot, marker) if spot != nil
      spot
    end

    def play_game
      until game_over? || no_moves_left?
        make_move
      end
    end

    def manually_update_board(spot, marker)
      @board.fill_spot(spot, marker)
    end

    def no_moves_left?
      if current_player.ui
        current_player.ui.no_more_moves_allowed?
      else
        false
      end
    end

    def current_state
      @board.surface
    end

    def update_board_state(new_state)
      @board.surface = new_state
    end

    def current_player
      marker = @board.next_marker
      @players.find(&check_player(marker))
    end

    def current_marker
      @board.next_marker
    end

    def previous_player
      marker = @board.next_marker
      @players.find {|player| player.marker != marker}
    end

    def game_winner
      marker = @board.winning_marker
      @players.find(&check_player(marker))
    end

    def game_won_by_player?
      @board.solved_board?
    end

    def check_player(marker)
      Proc.new {|player| player.marker == marker}
    end
  end
end

