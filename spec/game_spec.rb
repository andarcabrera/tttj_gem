require 'rspec'
require 'spec_helper'
require_relative '../lib/ttt/game'


describe TTT::Game do

  let(:board) { double('board') }

  describe "game_over?" do
    it 'returns false if board is not solved or tied' do
      allow(board).to receive(:solved_board?).and_return(nil)
      allow(board).to receive(:tied_board?).and_return(nil)

      expect(TTT::Game.game_over?(board)).to be nil
    end

    it 'returns true if board is solved' do
      allow(board).to receive(:solved_board?).and_return(true)
      allow(board).to receive(:tied_board?).and_return(nil)

      expect(TTT::Game.game_over?(board)).to be true
    end

    it 'returns true if board is toed' do
      allow(board).to receive(:solved_board?).and_return(nil)
      allow(board).to receive(:tied_board?).and_return(true)

      expect(TTT::Game.game_over?(board)).to be true
    end
  end

end
