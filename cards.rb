# frozen_string_literal: true

require_relative '../../my_tasks/BlackJack/players'

class Cards
  attr_reader :cards, :choosen_card, :list, :card_weight, :cards_without_lears

  def initialize
    @cards = []
    num = []
    (2..10).step(1).to_a.each { |x| num << x.to_s }
    @cards_without_lears = num | %w[J Q K A]
    lears = ['♣', '♥', '♠', '♦']
    # lears = ['+', '<3', '^', '<>']
    lears.each do |y|
      cards_without_lears.collect { |x| @cards << (x + y).to_s }
    end
    @cards
  end
end

