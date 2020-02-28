require 'cup'
require 'scorecard'
require 'Die'

class Player
  attr_reader :in_play, :cup, :scorecard

  def initialize()
    @in_play = []
    @cup = Cup.new()
    @scorecard = Scorecard.new()
    6.times do
      @cup.contents << Die.new()
    end
  end
end
