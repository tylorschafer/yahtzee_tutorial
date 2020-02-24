class Cup
  attr_reader :contents

  def initialize()
    @contents = nil
  end

  def load(dice)
    @contents.push(dice)
  end
end
