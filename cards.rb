# frozen_string_literal: true

require_relative '../../my_tasks/BlackJack/players'

class Cards
  attr_reader :cards_without_lears, :choosen_card, :full_cards, :sum_cards
  attr_accessor :deck

  def initialize
    @full_cards = []
    @deck = []
    num = []
    (2..10).step(1).to_a.each { |x| num << x.to_s }
    @cards_without_lears = num | %w[J Q K A]
    lears = ['♣', '♥', '♠', '♦']
    lears.each do |y|
      cards_without_lears.collect { |x| @deck << (x + y).to_s }
    end
    @full_cards = @deck
  end

  def cards_hash
    @hash = {}
    @full_cards.each do |card|
      @hash[card] = if card.to_i != 0
                      card.to_i
                    elsif card.chars[0] == 'A'
                      11
                    else
                      10
                    end
    end
    @hash
  end

  def choose_card
    @choosen_card = deck[rand(@deck.size)]
    self.deck -= [@choosen_card]
  end
end
