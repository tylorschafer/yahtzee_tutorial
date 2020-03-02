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
    selections = [@scorecard.upper_section.keys]
    selections.push(*@scorecard.lower_section.keys)
    selection = prompt.select('How would you like to score your dice?', selections)
    case selection
    when :aces
      score = @scorecard.tally_die(@in_play, 1, :aces)
      p "#{selection.to_s.tr('_', ' ')} has been scored for #{score} point!"
    when :twos
      score = @scorecard.tally_die(@in_play, 2, :twos)
      p "#{selection.to_s.tr('_', ' ')} has been scored for #{score} point!"
    when :threes
      score = @scorecard.tally_die(@in_play, 3, :threes)
      p "#{selection.to_s.tr('_', ' ')} has been scored for #{score} point!"
    when :fours
      score = @scorecard.tally_die(@in_play, 4, :fours)
      p "#{selection.to_s.tr('_', ' ')} has been scored for #{score} point!"
    when :fives
      score = @scorecard.tally_die(@in_play, 5, :fives)
      p "#{selection.to_s.tr('_', ' ')} has been scored for #{score} point!"
    when :sixes
      score = @scorecard.tally_die(@in_play, 6, :sixes)
      p "#{selection.to_s.tr('_', ' ')} has been scored for #{score} point!"
    when :full_house
      score = @scorecard.full_house(@in_play)
      p "#{selection.to_s.tr('_', ' ')} has been scored for #{score} point!"
    when :three_of_kind
      score = @scorecard.of_kind(@in_play, 3, :three_of_kind)
      p "#{selection.to_s.tr('_', ' ')} has been scored for #{score} point!"
    when :four_of_kind
      score = @scorecard.of_kind(@in_play, 4, :four_of_kind)
      p "#{selection.to_s.tr('_', ' ')} has been scored for #{score} point!"
    when :sm_straight
      score = @scorecard.straight(@in_play, 4, :sm_straight)
      p "#{selection.to_s.tr('_', ' ')} has been scored for #{score} point!"
    when :lg_straight
      score = @scorecard.straight(@in_play, 5, :lg_straight)
      p "#{selection.to_s.tr('_', ' ')} has been scored for #{score} point!"
    when :yahtzee
      score = @scorecard.yahtzee(@in_play)
      p "#{selection.to_s.tr('_', ' ')} has been scored for #{score} point!"
    when :chance
      valid = @scorecard.chance(@in_play)
      p "#{selection.to_s.tr('_', ' ')} has been scored for #{score} point!"
    end
  end
end
