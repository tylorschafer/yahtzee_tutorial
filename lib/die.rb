class Die
  attr_reader :values
  attr_accessor :curr_value, :number

  def initialize(number = 0)
    @values = [1,2,3,4,5,6]
    @curr_value = nil
    @number = number
  end

  def roll()
    @curr_value = @values.sample
  end
end
