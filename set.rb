# frozen_string_literal: true

require_relative '../BlackJack/cards'
class SetCards
  attr_reader :object_cards, :player, :dealer
  attr_accessor :cards

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
    @object_cards = Cards.new
      player.cards.clear
      dealer.cards.clear
    2.times do
      add_card_to(player)
      add_card_to(dealer)
    end
  end

  def player_move(deсision)
    case deсision
      when :else_one_card
        add_card_to(@player)
        score_player
        check_dealer
        cards_result
      when :dealer_move
        check_dealer
        cards_result
      when :open
        cards_result
    end
  end

  def add_card_to(name)
    @object_cards.choose_card
    added_card = @object_cards.choosen_card
    name.cards << added_card
  end

  def score_dealer
    @object_cards.value_cards(@dealer, @object_cards.cards_hash)
  end

  def score_player
    @object_cards.value_cards(@player, @object_cards.cards_hash)
  end

  #если у диллера меньше 16 очков, добавляем карту
  def check_dealer
    return if @object_cards.value_cards(@dealer, @object_cards.cards_hash) > 16
    add_card_to(@dealer)
  end


  def cards_result(name1 = @player, name2 = @dealer, cards_hash = @object_cards.cards_hash)
    if @object_cards.value_cards(name1, cards_hash) > 21 && @object_cards.value_cards(name2, cards_hash) > 21
      'draw'
    elsif @object_cards.value_cards(name1, cards_hash) > 21 && @object_cards.value_cards(name2, cards_hash) <= 21
      name2.name
    elsif @object_cards.value_cards(name1, cards_hash) <= 21 && @object_cards.value_cards(name2, cards_hash) > 21
      name1.name
    elsif @object_cards.value_cards(name1, cards_hash) > @object_cards.value_cards(name2, cards_hash)
      name1.name
    elsif @object_cards.value_cards(name1, cards_hash) < @object_cards.value_cards(name2, cards_hash)
      name2.name
    else
      'draw'
    end
  end
end
