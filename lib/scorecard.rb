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

  def tally_die(dice, curr_value, name)
    tally = dice.select { |die| die.curr_value == curr_value }.sum(&:curr_value)
    @upper_section[name] = tally
    @total_score += tally
    tally
  end

  def three_of_kind(dice)
    num = group_finder(dice).max_by { |k,v| v }
    score = num[1] >= 3 ? num[0] * num[1] : false
    if score
      @total_score += score
      @lower_section[:three_of_kind] = score
    else
      false
    end
  end
end
