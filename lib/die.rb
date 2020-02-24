class Die
  attr_reader :curr_value, :values

  def initialize()
    @values = [1,2,3,4,5,6]
    @curr_value = nil
  end

  def roll()
    @curr_value = @values.sample
  end
end
