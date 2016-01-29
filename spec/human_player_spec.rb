require_relative '../lib/ttt/human_player'

describe TTT::HumanPlayer do

  let(:input) { double('input', :error => "Invalid Player Input") }
  let(:board) { double('board') }
  let(:human) { TTT::HumanPlayer.new("Anda", "X", input) }

  describe "#pick_spot" do
    it "returns the spot selected by the human user when the spot is available" do
      allow(board).to receive(:available_spot?).and_return(true)
      allow(input).to receive(:get_spot).and_return(5)

      expect(human.pick_spot(board)).to eq(5)
    end

    it "raises an erorr if the spot selected by the human user is not available" do
      allow(board).to receive(:available_spot?).and_return(false, false, true)
      allow(input).to receive(:get_spot).and_return("k", "L", 3)

      expect(human.pick_spot(board)).to eq(3)
    end
  end
end
