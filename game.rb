# frozen_string_literal: true

require_relative 'players.rb'
require_relative 'round.rb'

class Game
  attr_reader :player, :dealer
  attr_accessor :round

  def initialize(name)
    @player = Players.new(name)
    @dealer = Players.new('dealer')
    start_new_round
  end

  def start_new_round
    @round = Round.new(@player, @dealer)
  end
end
