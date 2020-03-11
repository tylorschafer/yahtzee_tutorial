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
    selection = prompt.multi_select('What Dice would you like to Load?', dice)
    user_selection = selection.map { |die| die[5].to_i }
    user_selection.each do |selection|
      die = @in_play.find { |die| die.number == selection }
      @cup.contents << die
      @in_play.delete(die)
    end
  end

  def roll()
    prompt = TTY::Prompt.new
    selection = prompt.select('Are you ready to roll your dice?', %w(yes no))
    if selection == 'yes'
      dice = @cup.pour().map { |die| "| #{die.curr_value} |" }
      puts "You rolled " + dice.join(' ')
    end
  end

  ## This needs a design overhual, more helper methods
  ## Need a warning for asking the player to add 0 scores, or markoffs in Yahtzee terms

  def score()
    prompt = TTY::Prompt.new
    selections = find_unscored_options()
    binding.pry
    selection = prompt.select('How would you like to score your dice?', selections)
  end

  def find_unscored_options()
    upper = @scorecard.upper_section.find_all { |key, score| score == 0 }.map{|k,v| k}
    lower = @scorecard.lower_section.find_all { |key, score| score == 0 }.map{|k,v| k}
    upper + lower
  end
end
