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

  def of_kind(dice, number, name)
    num = group_finder(dice).max_by { |k,v| v }
    score = num[1] >= number ? num[0] * num[1] : false
    if score
      @total_score += score
      @lower_section[name] = score
    else
      false
    end
  end

  def full_house(dice)
    valid = group_finder(dice).values.all? { |value| value == 2 }
    if valid
      @total_score += 25
      @lower_section[:full_house] = 25
    else
      false
    end
  end

  def straight(dice, num, name)
    valid = seq_finder(dice) >= num
    if valid
      num == 4 ? @lower_section[name] = 30 : @lower_section[name] = 40
      num == 4 ? @total_score += 30 : @total_score += 40
    else
      false
    end
  end
end
