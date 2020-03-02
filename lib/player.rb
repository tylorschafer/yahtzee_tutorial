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
    6.times do
      @cup.contents << Die.new()
    end
  end

  def load()
    prompt = TTY::Prompt.new
    dice = @in_play.map { |die| "| #{die.curr_value} |" }
    dice << "I don't want to load any dice"
    prompt.multi_select('What Dice would you like to Load?', dice)
  end
end
