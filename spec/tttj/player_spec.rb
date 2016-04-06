require 'spec_helper'
require 'tttj/player'

describe TTT::Player do

  let(:player) { TTT::Player.new("Anda", "X") }
  describe "#name" do
    it "returns the player name" do
      expect(player.name).to eq("Anda")
    end
  end

  describe "#marker" do
    it "returns the player marker" do
      expect(player.marker).to eq("X")
    end
  end
end
