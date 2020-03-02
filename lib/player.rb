require 'cup'
require 'scorecard'
require 'Die'
require 'tty-prompt'

class Player
  attr_accessor :in_play, :cup, :scorecard

  def initialize()
    @in_play = []
    @cup = Cup.new()
    @scorecard = Scorecard.new()
    @die_count = 1
    6.times do
      @cup.contents << Die.new(@die_count)
      @die_count += 1
    end
  end

  def load()
    prompt = TTY::Prompt.new
    dice = @in_play.map { |die| "Die ##{die.number} | #{die.curr_value} |" }
    dice << "I don't want to load any dice"
    selection = prompt.multi_select('What Dice would you like to Load?', dice)
    user_selection = selection.map { |die| die[5].to_i }
    user_selection.each do |selection|
      die = @in_play.find { |die| die.number == selection }
      @cup.contents << die
      @in_play.delete(die)
    end
  end
end
