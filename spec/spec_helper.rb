require 'simplecov'
SimpleCov.start do
   add_filter 'spec'
 end

require_relative '../lib/ttt/computer_move'
require_relative '../lib/ttt/board'
require_relative '../lib/ttt/game'
