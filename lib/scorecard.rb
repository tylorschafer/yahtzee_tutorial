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
end
