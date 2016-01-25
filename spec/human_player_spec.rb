require 'rspec'
require 'spec_helper'
require_relative '../lib/ttt/players/human_player'


  describe "pick_spot" do

  let (:human_player) { HumanPlayer.new("Anda", "X") }
    it "picks a spot to place its marker" do

      expect(human_player.pick_spot(1)).to eq(1)
    end
  end
