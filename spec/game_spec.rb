require 'rspec'
require 'spec_helper'
require_relative '../lib/ttt/game'


describe TTT::Game do

  let(:players) {[{:name=>"Anda", :marker=>"X", :type=>"human"}, {:name=>"Mary", :marker=>"Y", :type=>"computer"}]}
  let(:human_move) { double 'human_move' }
  let(:game) { TTT:: Game.new(players, human_move)}

  describe "game_over?" do
    it 'returns false if board is not solved or tied' do
      expect(game.game_over?).to be false
    end

    it 'returns true if board is solved' do
      simulate_game([0, 4, 1, 5, 2])

      expect(game.game_over?).to be true
    end

    it 'returns true if board is tied' do
      simulate_game([0, 2, 1, 3, 5, 4, 6, 7, 8])

      expect(game.game_over?).to be true
    end
  end

  describe "move" do
     it 'updates spot with given marker' do
      game.make_move(5)

      expect(game.current_state).to eq(["0", "1", "2", "3", "4", "X", "6", "7", "8"])
    end
  end

  describe "#selected_spot" do
    context "player is human" do
      it "returns spot selected by human" do
        allow(human_move).to receive(:pick_spot).and_return(3)

        expect(game.selected_spot).to eq(3)
      end
    end

    context "player is computer" do
      it "returns spot selected by computer" do
        game.make_move(4)
        allow(game).to receive(:computer_move).and_return(5)

        expect(game.selected_spot).to eq(5)
      end
    end
  end

  describe "#game_winner" do
    it 'returns the player with the winning marker' do
      simulate_game([0, 4, 1, 5, 2])

      expect(game.game_winner).to eq({:name=>"Anda", :marker=>"X", :type=>"human"})
    end
  end

  def simulate_game(array)
    array.each {|spot| game.make_move(spot)}
  end
end
