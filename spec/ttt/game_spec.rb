require 'spec_helper'
require 'ttt/game'


describe TTT::Game do

  let(:player1) { double 'player1', :marker => "X", :name => "Anda" }
  let(:ui) { double 'ui' }
  let(:player2) { double 'player2', :marker => "Y", :name => "Eli" }
  let(:players) { [player1, player2] }
  let(:db) { double 'db', :save_game => nil }
  let(:game) { TTT::Game.new(db, players)}

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

  describe "make_move" do
     it 'updates spot with given marker' do
       allow(player1).to receive(:pick_spot).and_return(1)
       game.make_move

       expect(game.current_state).to eq(["0", "X", "2", "3", "4", "5", "6", "7", "8"])
    end

     it 'saves the game when the game is over' do
       allow(player1).to receive(:pick_spot).and_return('0', '1', '2', '3')
       allow(player2).to receive(:pick_spot).and_return('3', '4', '5', '6')
       5.times {game.make_move}

       expect(game.game_over?).to be(true)
    end
  end

  describe "#no_moves_left?" do
     it 'returns true if no other moves are possible' do
       allow(player1).to receive(:ui).and_return(ui)
       allow(ui).to receive(:no_more_moves_allowed?).and_return(true)

       expect(game.no_moves_left?).to be true
    end

     it 'returns false if other moves are possible' do
       allow(player1).to receive(:ui).and_return(nil)

       expect(game.no_moves_left?).to be false
    end
  end


  describe "#game_winner" do
    it 'returns the player with the winning marker' do
      simulate_game([0, 4, 1, 5, 2])

      expect(game.game_winner).to eq(player1)
    end
  end

  describe "#manually_update_board" do
    it "updates the board with given board status" do
      game.manually_update_board(3, "N")

      expect(game.current_state).to eq(["0", "1", "2", "N", "4", "5", "6", "7", "8"])
    end
  end

  describe "#markers" do
    it "returns the markers" do
      expect(game.markers).to eq(["X", "Y"])
    end
  end

  describe "#previous_player" do
    it 'returns the player that made the move a turn ago' do
      simulate_game([0, 4, 1, 5, 8])

      expect(game.previous_player).to eq(player1)
    end
  end

  def simulate_game(array)
    array.each do |spot|
      marker = game.current_player.marker
      game.manually_update_board(spot, marker)
    end
  end
end
