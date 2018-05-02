# frozen_string_literal: true

require_relative 'players'
require_relative '../BlackJack/cards'

class Main
  attr_reader :deck, :name, :constant_deck, :your_sum
  attr_accessor :new_cards
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
        add_cards
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
    @new_cards = Cards.new
    @deck = @new_cards.cards
    @constant_deck = @new_cards.cards
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
    @player.make_a_bet
    @diller.make_a_bet
    puts "Ваши карты, #{@name}"
    puts @player.cards
    puts 'Карты диллера:'
    puts '**'
    puts 'Сумма ваших очков:'
    puts @your_sum = @new_cards.value_cards(@player)
    puts 'Сумма очков диллера'
    puts '**'
  end

  def add_cards
    add_card(@player)
    add_card(@diller)
  end

  def miss_movie
    if @new_cards.value_cards(@diller) > 16
      puts 'Диллеру хватит'
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
    return if name.cards.length == 3
    return if name == @diller && @new_cards.value_cards(@diller) > 16
    name.cards << @choosen_card
    if name.name == @player.name then puts "Добавленная карта #{@choosen_card}"
                                      puts "Сумма ваших очков #{@new_cards.value_cards(name)}"
    else
      puts 'Диллеру добавлена карта'
    end
  end

  def result
    @new_cards.cards_result(@player, @diller)
  end
end

Main.new.start
