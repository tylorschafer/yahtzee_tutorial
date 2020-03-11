class Cup
  attr_accessor :contents

  def initialize()
    @contents = []
  end

  def load(dice)
    dice.each { |die| @contents << die }
  end

  def pour()
    rolled_dice = @contents
    rolled_dice.each { |die| die.roll() }
    @contents = []
    rolled_dice
  end
end
