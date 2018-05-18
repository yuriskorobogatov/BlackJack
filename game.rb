# frozen_string_literal: true

require_relative 'player.rb'
require_relative 'round.rb'

class Game
  attr_reader :player, :dealer
  attr_accessor :round

  def initialize(name)
    @player = Player.new(name)
    @dealer = Player.new('dealer')
    start_new_round
  end

  def start_new_round
    @round = Round.new(@player, @dealer)
  end
end
