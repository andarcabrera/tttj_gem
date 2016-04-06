require 'tttj/computer_player'
require 'tttj/human_player'
require 'tttj/user_interface'


module TTT
  class GameSetup

    attr_reader :game_info

    def initialize(game_info, spot_params = nil)
      @game_info = game_info
      @spot = spot_params
      @ui = UserInterface.new(@spot)
    end

    def create_players
      players = []
      if game_info["player1_type"] == "computer"
        players << TTT::ComputerPlayer.new(game_info["player1_name"], game_info["player1_marker"])
      else
        players << TTT::HumanPlayer.new(game_info["player1_name"], game_info["player1_marker"], UserInterface.new(@spot))
      end

      if game_info["player2_type"] == "computer"
        players << TTT::ComputerPlayer.new(game_info["player2_name"], game_info["player2_marker"])
      else
        players << TTT::HumanPlayer.new(game_info["player2_name"], game_info["player2_marker"], @ui)
      end
      players
    end
  end
end

