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

  #назначить каждой карте её вес. Ключ - катра, значение - вес карты.
  def self.cards_hash
    hash = {}
    Cards.new.cards.each  do |card|
      if card.to_i !=0
      hash[card] = card.to_i
      elsif card.chars[0] == 'A'
        hash[card] = [1,11]
      else
        hash[card] = 10
      end
      end
    puts hash
  end
end

Cards.cards_hash

# alphabet = ('a'..'z').to_a
# vowels = %w(a e i o u y)
# hash = {}
# alphabet.each.with_index(1) do |letter, index|
#   hash[letter] = index if vowels.include?(letter)
# end
# puts hash