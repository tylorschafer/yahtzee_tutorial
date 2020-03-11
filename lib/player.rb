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

  def score()
    prompt = TTY::Prompt.new
    selections = find_unscored_options()
    selection = prompt.select('How would you like to score your dice?', selections)
    if [:aces, :twos, :threes, :fours, :fives, :sixes].include?(selection)
      score = upper_score_loader(selection)
    else
      score = lower_score_loader(selection)
    end
      "You scored #{score} on #{selection}"
  end

  def upper_score_loader(name)
    case name
    when :aces
      @scorecard.tally_die(@in_play, 1, :aces)
    when :twos
      @scorecard.tally_die(@in_play, 2, :twos)
    when :threes
      @scorecard.tally_die(@in_play, 3, :threes)
    when :fours
      @scorecard.tally_die(@in_play, 4, :fours)
    when :fives
      @scorecard.tally_die(@in_play, 5, :fives)
    when :sixes
      @scorecard.tally_die(@in_play, 6, :sixes)
    end
  end

  def lower_score_loader()
  end

  def find_unscored_options()
    upper = @scorecard.upper_section.find_all { |key, score| score == 0 }.map{|k,v| k}
    lower = @scorecard.lower_section.find_all { |key, score| score == 0 }.map{|k,v| k}
    upper + lower
  end
end
