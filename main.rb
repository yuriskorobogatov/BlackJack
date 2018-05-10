# frozen_string_literal: true

require_relative 'players'
require_relative '../BlackJack/cards'
require_relative 'game'
require_relative '../../my_tasks/BlackJack/set'

class Main
  attr_reader :name
  attr_accessor :new_game, :new_set

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
    @new_game = Game.new(@name)
  end

  def give_out_cards
    if @new_game.player.money.zero? || @new_game.diller.money.zero?
      puts 'Нет денег для продолжения игры. Начните новую игру'
      return
    end
    @new_set = SetCards.new(@new_game.player, @new_game.diller)
    puts "Ваши карты, #{@name}"
    puts @new_game.player.cards
    puts 'Карты диллера:'
    puts '**'
    puts 'Сумма ваших очков:'
    puts @new_set.value_cards(@new_game.player, @new_set.object_cards.cards_hash)
    puts 'Сумма очков диллера:'
    puts '**'
  end

  def add_cards
    @new_set.add_card_to(@new_game.player)
    puts "Игроку добавлена карта #{@new_game.player.cards[-1]}"
    puts "Количество очков игрока: #{@new_set.value_cards(@new_game.player, @new_set.object_cards.cards_hash)}"
    if @new_set.value_cards(@new_game.diller, @new_set.object_cards.cards_hash) > 16
      return
    else
      @new_set.add_card_to(@new_game.diller)
      puts 'Диллеру добавлена карта'
    end
  end

  def miss_movie
    if @new_set.value_cards(@new_game.diller, @new_set.object_cards.cards_hash) > 16 ||
       @new_game.diller.cards.length == 3
      puts 'Диллеру хватит'
    else
      @new_set.add_card_to(@new_game.diller)
      puts 'Диллеру добавлена карта'
    end
  end

  def result
    puts "Количество очков у Вас #{@new_set.value_cards(@new_game.player, @new_set.object_cards.cards_hash)}"
    puts "Количество очков у диллера #{@new_set.value_cards(@new_game.diller, @new_set.object_cards.cards_hash)}"
    if @new_set.cards_result(@new_game.player, @new_game.diller, @new_set.object_cards.cards_hash) == 'win'
      puts 'Победа'
      puts " У вас #{@new_game.win(@new_game.player)} рублей"
      puts " У диллера #{@new_game.loose(@new_game.diller)} рублей"
    elsif @new_set.cards_result(@new_game.player, @new_game.diller, @new_set.object_cards.cards_hash) == 'loose'
      puts 'Проигрыш'
      puts " У вас #{@new_game.loose(@new_game.player)} рублей"
      puts " У диллера #{@new_game.win(@new_game.diller)} рублей"
    else
      puts 'Ничья'
      puts " У вас #{@new_game.player.money} рублей"
      puts " У диллера #{@new_game.diller.money} рублей"
    end
  end
end

Main.new.start
