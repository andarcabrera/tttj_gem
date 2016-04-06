require 'spec_helper'
require 'tttj/game_setup'

describe TTT::GameSetup do

  context 'it creates two players' do
      it 'creates 2 human players' do
        setup = TTT::GameSetup.new({:size => "9",
                                "player1_type" => "human",
                                "player1_marker" => "X",
                                "player1_name" => "Player1",
                                "player2_type" =>"human",
                                "player2_marker" => "Y",
                                "player2_name" => "Player2"})

        expect(setup.create_players[0].class).to eq(TTT::HumanPlayer)
        expect(setup.create_players[1].class).to eq(TTT::HumanPlayer)
      end

      it 'creates 2 computer players' do
        setup = TTT::GameSetup.new({:size => "16",
                                "player1_type" => "computer",
                                "player1_marker" => "X",
                                "player1_name" => "Player1",
                                "player2_type" =>"computer",
                                "player2_marker" => "Y",
                                "player2_name" => "Player2"})

        expect(setup.create_players[0].class).to eq(TTT::ComputerPlayer)
        expect(setup.create_players[1].class).to eq(TTT::ComputerPlayer)
      end

      it 'creates 1 computer and 1 human player' do
        setup = TTT::GameSetup.new({:size => "9",
                                "player1_type" => "human",
                                "player1_marker" => "X",
                                "player1_name" => "Player1",
                                "player2_type" =>"computer",
                                "player2_marker" => "Y",
                                "player2_name" => "Player2"})

        expect(setup.create_players[0].class).to eq(TTT::HumanPlayer)
        expect(setup.create_players[1].class).to eq(TTT::ComputerPlayer)
      end
    end
end