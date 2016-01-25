require 'rspec'
require 'spec_helper'
require_relative '../lib/ttt/players/player'

describe Player do

  let (:player) { Player.new("Anda", "X") }

  it 'has a name' do

    expect(player.name).to eq("Anda")
  end

  it 'has a marker' do

    expect(player.marker).to eq("X")
  end
end
