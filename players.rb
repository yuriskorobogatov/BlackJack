# frozen_string_literal: true

class Players
  attr_reader :name, :choosen_card, :cards, :money

  def initialize(name, money = 100)
    @name = name
    @money = money
    @cards = []
  end

  def make_a_bet
    @money -= 10
  end

  def win
    @money += 20
  end

  def draw
    @money += 10
  end

  def add_card(added_card, name_p, name_d, new_cards)
    return if cards.length == 3
    return if self == name_d && new_cards.value_cards(name_d) > 16
    @cards << added_card
    if name == name_p.name then puts "Добавленная карта #{added_card}"
                                puts "Сумма ваших очков #{new_cards.value_cards(name_p)}"
    else
      puts 'Диллеру добавлена карта'
    end
  end

  def clear_cards
    3.times do
      @cards.delete_at(0)
    end
  end
end
