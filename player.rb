# frozen_string_literal: true

class Player
  attr_reader :name, :cards
  attr_accessor :money
  def initialize(name, money = 100)
    @name = name
    @money = money
    @cards = []
  end
end
