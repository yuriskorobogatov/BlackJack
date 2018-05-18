# frozen_string_literal: true

require_relative '../../my_tasks/BlackJack/players'
require_relative '../../my_tasks/BlackJack/set'

class Game
  attr_reader :player, :dealer
  attr_accessor :set

  def initialize(name)
    @player = Players.new(name)
    @dealer = Players.new('dealer')
    start_new_set
  end

  def start_new_set
    @set = SetCards.new(@player, @dealer)
  end
end
