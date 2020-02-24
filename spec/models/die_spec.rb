require 'spec_helper'

describe Die, type: :model do

  before :each do
    @die = Die.new()
  end

  describe 'Instantiation' do
    it 'Can Exist' do
      expect(@die).to be_an_instance_of(Die)
    end

    it 'Has the correct starting attributes' do
      expect(@die.values).to eq([1,2,3,4,5,6])
      expect(@die.curr_value).to eq(nil)
    end
  end

  describe 'Instance Methods' do
    it 'roll() assigns a new random curr_value' do
      expect(@die.curr_value).to eq(nil)
      @die.roll()
      expect(@die.curr_value).to not_eq(nil)
    end
  end
end
