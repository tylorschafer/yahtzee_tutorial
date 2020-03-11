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

  def take_turn
    rolls = 3
    prompt = TTY::Prompt.new
    while rolls > 0
      roll()
      rolls -= 1
      player_dice = @in_play.map { |die| "| #{die.curr_value} |" }
      puts "You Currently have " + player_dice.join(' ')
      selection = prompt.select(
        "Would you like to roll again? You have #{rolls} remaining", %w(yes no)
      )
      selection == 'yes' ? load() : break
    end
    player_dice = @in_play.map { |die| "| #{die.curr_value} |" }
    puts "You Currently have " + player_dice.join(' ')
    score()
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
    rolled_dice = @cup.pour()
    @in_play += rolled_dice
    dice = rolled_dice.map { |die| "| #{die.curr_value} |" }
    puts "You rolled " + dice.join(' ')
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
      p "You scored #{score} on #{selection.to_s}"
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

  def lower_score_loader(name)
    case name
    when :three_of_kind
      @scorecard.of_kind(@in_play, 3, :three_of_kind)
    when :four_of_kind
      @scorecard.of_kind(@in_play, 4, :four_of_kind)
    when :full_house
      @scorecard.full_house(@in_play)
    when :sm_straight
      @scorecard.straight(@in_play, 4, :sm_straight)
    when :lg_straight
      @scorecard.straight(@in_play, 5, :lg_straight)
    when :yahtzee
      @scorecard.yahtzee(@in_play)
    when :chance
      @scorecard.chance(@in_play)

    end
  end

  def find_unscored_options()
    upper = @scorecard.upper_section.find_all { |name, score| score == 0 }.map{|k,v| k}
    lower = @scorecard.lower_section.find_all { |name, score| score == 0 }.map{|k,v| k}
    upper + lower
  end
end
