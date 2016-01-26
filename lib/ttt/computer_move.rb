module TTT

  class ComputerMove

    def self.computer_move(board)
      return board.available_spots.sample if board.available_spots.count >= 13 && board.size == 16
      return '4' if board.available_spots.count == 9 && board.size == 9

      threads = []
      spots_scores = []

       board.available_spots.each do |available_spot|
         board.fill_spot(available_spot, board.next_marker)
         board_copy = Marshal::load(Marshal.dump(board))
          threads << [Thread.new(board_copy) { Thread.current[:value] = -1 * alpha_beta_negamax(board_copy) }, available_spot]
         ComputerMove.reset_spot(board, available_spot)
       end

       threads.each do |thread, spot|
        thread.join
        spots_scores << [spot, thread[:value]]
       end

       best_spot = spots_scores.max_by { |key, value| value }[0]
    end

    def self.alpha_beta_negamax(board, depth = 0, alpha = - Float::INFINITY, beta = Float::INFINITY)
      return 0 if board.tied_board?
      return -1 if board.solved_board?

      best_score = {}

      board.available_spots.each do |available_spot|
        board.fill_spot(available_spot, board.next_marker)
        best_score[available_spot.to_i] = -1 * alpha_beta_negamax(board, depth + 1, -beta, -alpha)
        if best_score[available_spot.to_i] > alpha
          alpha = best_score[available_spot.to_i]
        end
        if alpha >= beta
          reset_spot(board, available_spot)
          return best_score[available_spot.to_i] = alpha
        end
        reset_spot(board, available_spot)
      end

      max_score = best_score.max_by { |key, value| value }[1].to_i
    end

    private

    def self.reset_spot(board, spot)
      board.fill_spot(spot, spot)
    end

  end
end
