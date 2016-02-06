require 'spec_helper'
require 'ttt/computer_player'

describe TTT::ComputerPlayer do

  let(:board) { double('board') }
  let(:computer) { TTT::ComputerPlayer.new("Computer", "Y") }

  describe "#pick_spot" do
    it "returns the spot selected by the computer" do
      expect(TTT::ComputerMove).to receive(:computer_move).and_return(5)

      expect(computer.pick_spot(board)).to eq(5)
    end
  end
end
