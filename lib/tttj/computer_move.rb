module TTT

  class ComputerMove

    def self.computer_move(board)
      ComputerMove.alpha_beta_negamax(board, depth = 0)
    end


  def self.alpha_beta_negamax(board, depth, alpha = - Float::INFINITY, beta = Float::INFINITY)
    return board.available_spots.sample if board.available_spots.count >= 13 && board.size == 16
    return '4' if board.available_spots.count == 9 && board.size == 9
    best_score = {}

    return 0 if board.tied_board?
    return -1 if board.solved_board?

    board.available_spots.each do |available_spot|
      board.fill_spot(available_spot, board.next_marker)
      best_score[available_spot.to_i] = - alpha_beta_negamax(board, depth + 1, -beta, -alpha)
      if best_score[available_spot.to_i] > alpha
        alpha = best_score[available_spot.to_i]
      end
      if alpha >= beta
        reset_spot(board, available_spot)
        return best_score[available_spot.to_i] = alpha
      end
      reset_spot(board, available_spot)
    end

    best_spot = best_score.max_by { |key, value| value }[0].to_s
    max_score = best_score.max_by { |key, value| value }[1].to_i

    depth == 0 ? best_spot : max_score
  end

    private

    def self.reset_spot(board, spot)
      board.fill_spot(spot, spot)
    end

  end
end
