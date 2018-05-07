# frozen_string_literal: true

require_relative '../../my_tasks/BlackJack/players'

class Cards
  attr_reader :cards_without_lears, :choosen_card, :full_cards, :sum_cards
  attr_accessor :cards

  def initialize
    @full_cards = []
    @cards = []
    num = []
    (2..10).step(1).to_a.each { |x| num << x.to_s }
    @cards_without_lears = num | %w[J Q K A]
    lears = ['♣', '♥', '♠', '♦']
    lears.each do |y|
      cards_without_lears.collect { |x| @cards << (x + y).to_s }
    end
    @full_cards = @cards
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

  def value_cards(name)
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

  def choose_card
    @choosen_card = cards[rand(cards.size)]
    self.cards -= [@choosen_card]
  end

  def cards_result(name1, name2)
    puts "Количество очков у Вас #{value_cards(name1)}"
    puts "Количество очков у диллера #{value_cards(name2)}"
    if value_cards(name1) > 21 && value_cards(name2) > 21
      puts 'Ничья. Перебор у обоих игроков.'
      name1.draw
      name2.draw
    elsif value_cards(name1) > 21 && value_cards(name2) <= 21
      puts 'Проигрыш. У вас перебор.'
      name2.win
    elsif value_cards(name1) <= 21 && value_cards(name2) > 21
      puts 'Выигрыш. Перебор у диллера.'
      name1.win
    elsif value_cards(name1) > value_cards(name2)
      puts 'Поздравляем с победой'
      name1.win
    elsif value_cards(name1) < value_cards(name2)
      puts 'Проигрыш.'
      name2.win
    else
      puts 'Ничья'
      name1.draw
      name2.draw
    end
    check_result(name1, name2)
  end

  def check_result(name1, name2)
    puts "У вас #{name1.money} рублей"
    puts "У диллера #{name2.money} рублей"
    puts 'Игра закончена. Начните игру с начала.' if name1.money.zero? || name2.money.zero?
    nil
  end
end
