class Scorecard
  attr_reader :total_score, :upper_section, :lower_section

  def initialize()
    @total_score = 0
    @upper_section = {
      aces: 0,
      twos: 0,
      threes: 0,
      fours: 0,
      fives: 0,
      sixes: 0,
    }
    @lower_section = {
      three_of_kind: 0,
      four_of_kind: 0,
      full_house: 0,
      sm_straight: 0,
      lg_straight: 0,
      yahtzee: 0,
      chance: 0
    }
  end

  def group_finder(dice)
    dice.group_by(&:curr_value).map {|k,v| [k, v.size] }.to_h
  end

  def seq_finder(dice)
    curr_values = dice.map { |die| die.curr_value }.sort
    count = 1
    curr_values.each_cons(2) {|nums| count += 1 if nums[1] - nums[0] == 1 }
    count
  end


end
