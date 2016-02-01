require_relative '../lib/ttt/human_player'

describe TTT::HumanPlayer do

  let(:input) { double('input', :error => "Invalid Player Input") }
  let(:board) { double('board') }
  let(:human) { TTT::HumanPlayer.new("Anda", "X", input) }

  describe "#pick_spot" do
    it "returns the spot selected by the human user when the spot is available" do
      allow(board).to receive(:available_spot).and_return(true)
      allow(input).to receive(:get_spot).and_return(5)

      expect(human.pick_spot(board)).to eq(5)
    end

    it "asks for spot until available spot is found or no more moves are allowed" do
      allow(board).to receive(:available_spot).and_return(false, false, true)
      allow(input).to receive(:get_spot).and_return("k", "L", 3)
      allow(input).to receive(:no_more_moves_allowed?).and_return(false)

      expect(human.pick_spot(board)).to eq(3)
    end

    it "breaks loop is no more moves are allowed" do
      allow(board).to receive(:available_spot).and_return(false)
      allow(input).to receive(:get_spot).and_return(5, 5)
      allow(input).to receive(:no_more_moves_allowed?).and_return(true)

      expect(human.pick_spot(board)).to eq(5)
    end
  end
end
