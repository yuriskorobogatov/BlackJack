# frozen_string_literal: true

require_relative '../../my_tasks/BlackJack/players'

class Cards
  attr_reader :cards, :choosen_card, :list, :card_weight, :cards_without_lears
  attr_reader :constant_deck

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
  def cards_hash
    @hash = {}
    @cards.each  do |card|
      if card.to_i !=0
        @hash[card] = card.to_i
      elsif card.chars[0] == 'A'
        @hash[card] = 11
      else
        @hash[card] = 10
      end
    end
    @hash
  end

  #посчитать сумму очков у игрока
  def value_cards(name)
    @sum_cards = 0
    name.cards.each do |x|
      cards_hash.each_pair { |key, value| @sum_cards += value if x == key }
    end
    @sum_cards
  end

  def cards_result(name1, name2)
    puts "Количество очков у Вас #{value_cards(name1)}"
    puts "Количество очков у диллера #{value_cards(name2)}"
    if value_cards(name1) > 21 && value_cards(name2) > 21 then puts 'Ничья. Перебор у обоих игроков.'
    elsif
    value_cards(name1) > 21 && value_cards(name2) <= 21 then puts 'Проигрыш. У вас перебор.'
    elsif
    value_cards(name1) <= 21 && value_cards(name2) > 21 then puts 'Выигрыш. Перебор у диллера.'
    elsif
    value_cards(name1) > value_cards(name2) then puts 'Поздравляем с победой'
    elsif
    value_cards(name1) < value_cards(name2) then puts 'Проигрыш.'
    else
      puts 'Ничья'
    end
    return
  end
end

