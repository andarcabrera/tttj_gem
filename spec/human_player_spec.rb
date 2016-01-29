require_relative '../lib/ttt/players/human_player'

describe TTT::HumanPlayer do

  let(:input) { double('input', :get_spot => 5, :error => "Invalid Player Input") }
  let(:board) { double('board') }
  let(:human) { TTT::HumanPlayer.new("Anda", "X", input) }

  describe "#pick_spot" do
    it "returns the spot selected by the human user when the spot is available" do
      allow(board).to receive(:available_spot?).and_return(true)

      expect(human.pick_spot(board)).to eq(5)
    end

    it "raises an errorr if the spot selected by the human user is not available" do
      allow(board).to receive(:available_spot?).and_return(false)

      expect {human.pick_spot(board) }.to raise_error("Invalid Player Input")
    end
  end
end
