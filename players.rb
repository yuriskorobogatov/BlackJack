# frozen_string_literal: true

class Players
  attr_reader :cards, :name
  attr_accessor :money

  def initialize(name, money = 100)
    @name = name
    @money = money
    @cards = []
  end

  def make_a_bet
    @money -= 10
  end

  def win
    @money += 20
  end

  def draw
    @money += 10
  end
end
