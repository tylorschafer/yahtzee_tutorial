class Die
  attr_reader :values
  attr_accessor :curr_value

  def initialize()
    @values = [1,2,3,4,5,6]
    @curr_value = nil
  end

  def roll()
    @curr_value = @values.sample
  end
end
