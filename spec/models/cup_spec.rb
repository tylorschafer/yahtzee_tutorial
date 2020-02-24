require './spec/spec_helper'

RSpec.describe 'Cup' do
  before :each do
    @cup = Cup.new()
    @dice = []
    6.times do
      @dice << Die.new()
    end
  end

  describe 'Instantiation' do
    it 'Can Exist' do
      expect(@cup).to be_an_instance_of(Cup)
    end

    it 'Has the correct starting attributes' do
      expect(@cup.contents).to eq([])
    end
  end

  describe 'Instance Methods' do
    it 'load() can load a variable number of Die objects into contents' do
      expect(@cpu.contents).to eq([])
      @cup.load(@dice)
      expect(@cup.contents).to eq(@dice)
    end

    it 'pour() can roll all die in cup contents, contents are then emptied' do
      @cup.load(@dice)
      expect(@cup.contents).to eq(@dice)
      rolled_dice = @cup.pour()
      expect(rolled_dice).to be_an(Array)
      expect(rolled_dice[0]).to be_an_instance_of(Die)
      expect(rolled_dice[0].curr_value).to_not be(nil)
      expect(rolled_dice[1].curr_value).to_not be(nil)
      expect(rolled_dice[2].curr_value).to_not be(nil)
      expect(rolled_dice[3].curr_value).to_not be(nil)
      expect(rolled_dice[4].curr_value).to_not be(nil)
      expect(rolled_dice[5].curr_value).to_not be(nil)
      expect(@cup.contents).to eq([])
    end
  end
end
