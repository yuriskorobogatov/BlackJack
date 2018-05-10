# frozen_string_literal: true

require_relative '../BlackJack/cards'
class SetCards
  attr_reader :object_cards

  def initialize(player, diller)
    @object_cards = Cards.new
    3.times do
      player.cards.delete_at(0)
      diller.cards.delete_at(0)
    end

    2.times do
      add_card_to(player)
      add_card_to(diller)
    end
  end

  def add_card_to(name)
    @object_cards.choose_card
    added_card = @object_cards.choosen_card
    name.cards << added_card
  end

  def value_cards(name, cards_hash)
    @sum_cards = 0
    name.cards.each do |x|
      cards_hash.each_pair { |key, value| @sum_cards += value if x == key }
    end
    if @sum_cards > 21 && name.cards.find do |x|
      x.chars[0] == 'A'
    end
      @sum_cards -= 10
    end
    @sum_cards
  end

  def cards_result(name1, name2, cards_hash)
    if value_cards(name1, cards_hash) > 21 && value_cards(name2, cards_hash) > 21
      'draw'
    elsif value_cards(name1, cards_hash) > 21 && value_cards(name2, cards_hash) <= 21
      'loose'
    elsif value_cards(name1, cards_hash) <= 21 && value_cards(name2, cards_hash) > 21
      'win'
    elsif value_cards(name1, cards_hash) > value_cards(name2, cards_hash)
      'win'
    elsif value_cards(name1, cards_hash) < value_cards(name2, cards_hash)
      'loose'
    else
      'draw'
    end
  end
end
