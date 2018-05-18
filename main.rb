# frozen_string_literal: true

require_relative '../../my_tasks/BlackJack/game'

class Main
  attr_reader :name, :game

  def start
    loop do
      puts '
  ================================================
        Выбирите действие:
        1  - Начать новую игру
        0  - Выход
  ================================================='
      action = gets.to_i
      break if action.zero?
      case action
      when 1
        start_game
      else
        puts 'Введите 1 или 0'
      end
    end
  end

  protected

  def start_game
    puts 'Введите свое имя'
    @name = gets.chomp
    puts "Рад вас поприветствовать, #{@name}"
    @game = Game.new(@name)
    player_move
  end

  def player_move
    puts "Ваши карты:"
    puts @game.player.cards
    puts "Сумма ваших очков #{@game.set.score_player}"
    puts '
  ================================================
        Выбирите действие:
        1  - Добавить карту игроку
        2  - Пропустить ход
        3  - Открыть карты
  ================================================='
        move = gets.chomp.to_i
    case move
      when 1
        @game.set.player_move(:else_one_card)
        puts "Вам добавлена карта #{@game.player.cards[-1]}"
        puts "Сумма ваших очков #{@game.set.score_player}"
        puts "Сумма очков диллера #{@game.set.score_dealer}"
        puts "Победитель #{@game.set.cards_result}"
      when 2
        @game.set.player_move(:dealer_move)
        puts 'Диллеру достаточно'
        puts "Сумма ваших очков #{@game.set.score_player}"
        puts "Сумма очков диллера #{@game.set.score_dealer}"
        puts "Победитель #{@game.set.cards_result}"
      when 3
        @game.set.player_move(:open)
        puts "Сумма ваших очков #{@game.set.score_player}"
        puts "Сумма очков диллера #{@game.set.score_dealer}"
        puts "Победитель #{@game.set.cards_result}"
    end
    puts 'для продолжения игры нажмите 1, для завершения данной игры нажмите 0'
    choose = gets.chomp.to_i
    case choose
      when 1
        @game.start_new_set
        player_move
      when 2
        return
    end
  end
end

Main.new.start
