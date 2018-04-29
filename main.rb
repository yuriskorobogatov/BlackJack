# frozen_string_literal: true

require_relative 'players'
require_relative '../BlackJack/cards'

class Main
  attr_reader :deck, :name, :constant_deck, :sum_cards, :your_sum, :diller_sum
  attr_accessor :cards
  @deck = []

  def start
    loop do
      puts '
  ================================================
        Выбирите действие:
        1  - Начать игру с начала
        2  - Сдать карты на новый круг
        3  - Добавить карту
        4  - Пропустить ход
        5  - Открыть карты
        0  - Выход
  ================================================='
      action = gets.to_i
      break if action.zero?
      case action
      when 1
        start_game
      when 2
        give_out_cards
      when 3
        add_card(@player)
      when 4
          miss_movie
      when 5
          result
      else
        puts 'Введите число от 0 до 5'
      end
    end
  end

  protected

  def start_game
    puts 'Введите свое имя'
    @name = gets.chomp
    puts "Рад вас поприветствовать, #{@name}"
    @player = Players.new(name)
    @diller = Players.new('Diller')
  end

  def give_out_cards
    @deck = Cards.new.cards
    @constant_deck = @deck
#обновление списка карт. Реализовано плохо, нужно потом переделать
    3.times do
    @player.cards.delete_at(0)
    @diller.cards.delete_at(0)
    end
    2.times do
      choose_card
      @player.cards << @choosen_card
      choose_card
      @diller.cards << @choosen_card
    end
    puts "Ваши карты, #{@name}"
    puts @player.cards
    #puts "Карты диллера"
    #puts @diller.cards
    puts 'Сумма ваших очков:'
    puts @your_sum = value_cards(@player)
    # puts 'Сумма очков диллера'
    # puts @diller_sum = value_cards(@diller)
  end

  def miss_movie
    if value_cards(@diller) > 16
      puts 'Диллеру хватит'
      return
    else
      add_card(@diller)
    end
  end

  def choose_card
    @choosen_card = @deck[rand(@deck.size)]
    @deck -= [@choosen_card]
  end

  def add_card(name)
    choose_card
    name.cards << @choosen_card
    if name.name == @player.name then puts "Добавленная карта #{@choosen_card}"
    else
      puts 'Диллеру добавлена карта'
    end
# Эта часть только для проверки. Потом нужно будет убрать.
#     if value_cards(name) > 21 then puts "#{name.name} проиграл. Сумма очков у #{name.name} равна #{value_cards(name)}"
#       return
#     else
#       puts "Сумма очков у #{name.name}  равна #{value_cards(name)}"
#     end
  end

  #назначить каждой карте её вес. Ключ - катра, значение - вес карты.
  def cards_hash
    @hash = {}
    @constant_deck.each  do |card|
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

  def result
    puts "Количество очков у #{@name} #{value_cards(@player)}"
    puts "Количество очков у диллера #{value_cards(@diller)}"
    if value_cards(@player) > 21 || value_cards(@player) < value_cards(@diller) then puts 'Проигрыш.'
    elsif
       value_cards(@player) > value_cards(@diller) then puts 'Поздравляем с победой'
    elsif
    value_cards(@player) > 21 && value_cards(@diller) > 21 then puts 'Ничья. Перебор у обоих игроков.'
    elsif
    value_cards(@player) < 21 && value_cards(@diller) > 21 then puts 'Выигрыш. Перебор у диллера.'
    else
      puts 'Ничья'
    end
    return
  end
end

Main.new.start
