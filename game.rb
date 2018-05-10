# frozen_string_literal: true

require_relative '../../my_tasks/BlackJack/players'

class Game
  attr_reader :player, :diller

  def initialize(name)
    @player = Players.new(name)
    @diller = Players.new('diller')
  end

  def loose(name)
    name.money -= 10
  end

  def win(name)
    name.money += 10
  end
end
