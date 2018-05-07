# frozen_string_literal: true

require_relative 'players'
require_relative '../BlackJack/cards'

class Main
  attr_reader :name, :new_cards

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
    @player.clear_cards
    @diller.clear_cards
    2.times do
      @new_cards.choose_card
      @player.cards << @new_cards.choosen_card
      @new_cards.choose_card
      @diller.cards << @new_cards.choosen_card
    end
    @player.make_a_bet
    @diller.make_a_bet
    puts "Ваши карты, #{@name}"
    puts @player.cards
    puts 'Карты диллера:'
    puts '**'
    puts 'Сумма ваших очков:'
    puts @new_cards.value_cards(@player)
    puts 'Сумма очков диллера'
    puts '**'
  end

  def add_cards
    add_cards_to(@player)
    add_cards_to(@diller)
  end

  def miss_movie
    if @new_cards.value_cards(@diller) > 16
      puts 'Диллеру хватит'
    else
      add_cards_to(@diller)
    end
  end

  def result
    @new_cards.cards_result(@player, @diller)
  end

  def add_cards_to(who)
    @new_cards.choose_card
    added_card = @new_cards.choosen_card
    who.add_card(added_card, @player, @diller, @new_cards)
  end
end

Main.new.start
