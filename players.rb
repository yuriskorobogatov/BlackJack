
# frozen_string_literal: true

class Players
  attr_reader :cards, :name

  def initialize(name, money = 100)
    @name = name
    @money = money
    @cards = []
  end
end
