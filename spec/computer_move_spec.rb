require 'rspec'
require 'spec_helper'
require_relative '../lib/ttt/computer_move'


describe TTT::ComputerMove do

  let(:board) { TTT::Board.new(['X', 'Y']) }

  context 'it picks the best spot on the board' do
    it 'picks the winning spot if it can win in the same round' do
      board.set_surface(["Y", "Y", "2", "X", "4", "5", "X", "7", "X"])

      expect(TTT::ComputerMove.computer_move(board)).to eq("2")
    end

    it 'picks the winning spot if it can win in the same round' do
      board.set_surface(["Y", "X", "2", "Y", "4", "5", "6", "7", "X"])
      board.solved_board?

      expect(TTT::ComputerMove.computer_move(board)).to eq("6")
    end

    it 'picks the spot that would make the other player a winner' do
      board.set_surface(["X", "X", "2", "Y", "4", "5", "Y", "7", "X"])

      expect(TTT::ComputerMove.computer_move(board)).to eq("2")
    end

    it 'picks a random spot on the board if no winning combination available' do
      board.set_surface(["0", "1", "2", "3", "Y", "5", "6", "7", "X"])

      expect(TTT::ComputerMove.computer_move(board)).not_to be nil
    end

    it 'random spot is included in the available spots' do
      board.set_surface(["X", "1", "2", "3", "Y", "5", "6", "X", "8"])
      available = board.available_spots
      spot = TTT::ComputerMove.computer_move(board)

      expect(available).to include(spot)
    end

    it 'selects spot with the best chance of winning' do
      board.set_surface(["X", "Y", "2", "3", "X", "5", "6", "7", "Y"])
      expect(TTT::ComputerMove.computer_move(board)).to eq('3')
    end

    it 'picks spot number 4 if all spots on the board are available' do
      board.set_surface(["0", "1", "2", "3", "4", "5", "6", "7", "8"])

      expect(TTT::ComputerMove.computer_move(board)).to eq('4')
    end

    it 'picks spot number 4 if all spots on the board are available when board is 4x4' do
      board = TTT::Board.new(['X', 'Y'], 16)
      board.set_surface(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"])

      expect(TTT::ComputerMove.computer_move(board).to_i).to be_between(0, 15).inclusive
    end

    it 'prevents opponent from winning in a 4X4 board' do
      board = TTT::Board.new(['X', 'Y'], 16)
      board.set_surface(["X", "X", "X", "3", "4", "X", "6", "Y", "8", "Y", "10", "Y", "12", "13", "14", "15"])

      expect(TTT::ComputerMove.computer_move(board)).to eq('3')
    end

    it 'makes the winning move if available' do
      board = TTT::Board.new(['X', 'Y'], 16)
      board.set_surface(["X", "1", "X", "3", "Y", "Y", "6", "Y", "X", "9", "10", "Y", "X", "13", "14", "15"])

      expect(TTT::ComputerMove.computer_move(board)).to eq('6')
    end
  end
end
