require 'spec_helper'
require 'tttj/human_player'

describe TTT::HumanPlayer do

  let(:ui) { double('input', :error => "Invalid Player Input") }
  let(:board) { double('board') }
  let(:human) { TTT::HumanPlayer.new("Anda", "X", ui) }

  describe "#pick_spot" do
    it "returns the spot selected by the human user when the spot is available" do
      allow(board).to receive(:available_spot?).and_return(true)
      allow(ui).to receive(:get_spot).and_return(5)

      expect(human.pick_spot(board)).to eq(5)
    end

    it "asks for spot until available spot is found or no more moves are allowed" do
      allow(board).to receive(:available_spot?).and_return(false, false, true)
      allow(ui).to receive(:get_spot).and_return("k", "L", 3)
      allow(ui).to receive(:no_more_moves_allowed?).and_return(false)

      expect(human.pick_spot(board)).to eq(3)
    end

    it "breaks loop is no more moves are allowed" do
      allow(board).to receive(:available_spot?).and_return(false, false)
      allow(ui).to receive(:get_spot).and_return(5, 6)
      allow(ui).to receive(:no_more_moves_allowed?).and_return(false, true)

      expect(human.pick_spot(board)).to eq(nil)
    end
  end
end
