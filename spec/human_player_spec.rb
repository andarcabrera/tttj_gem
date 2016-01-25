require 'rspec'
require 'spec_helper'
require_relative '../lib/ttt/players/human_player'


  describe "pick_spot" do

    let (:human_player) { HumanPlayer.new("Anda", "X") }
    let (:board) { double 'board' }

    it "picks a spot to place its marker" do
      allow(board).to receive(:available_spot).and_return(true)
      user_input = 5

      expect(human_player.pick_spot(board, user_input)).to eq(5)
    end

    it "returns nil if spot is not available on the board" do
      allow(board).to receive(:available_spot).and_return(false)
      user_input = 5

      expect(human_player.pick_spot(board, user_input)).to eq(nil)
    end
  end
