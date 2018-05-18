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
        0  - Выход из программы
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
        show_results
      when 2
        @game.set.player_move(:dealer_move)
        puts 'Диллеру достаточно'
        show_results
      when 3
        @game.set.player_move(:open)
        show_results
    end
    return if @game.player.money < 10 || @game.dealer.money < 10
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

  def show_results
    puts "Сумма ваших очков #{@game.set.score_player}"
    puts "Ваш баланс составляет #{@game.set.player_money}"
    puts "Сумма очков диллера #{@game.set.score_dealer}"
    puts "Баланс диллера составляет #{@game.set.dealer_money}"
    if @game.set.cards_result == 'draw'
      puts 'Ничья'
    else
      puts "Победитель #{@game.set.cards_result}"
    end
  end
end

Main.new.start
