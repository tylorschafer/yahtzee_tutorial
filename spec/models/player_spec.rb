require './spec/spec_helper'

RSpec.describe 'Player' do
  before :each do
    @player = Player.new()
  end

  describe 'Instantiation' do
    it 'Can Exist' do
      expect(@player).to be_an_instance_of(Player)
    end

    describe 'Attributes' do
      it '@in_play starts as an empty array' do
        expect(@player.in_play).to eq([])
      end

      it '@cup is a new cup object and starts with 6 new die in contents' do
        expect(@player.cup).to be_an_instance_of(Cup)
        expect(@player.cup.contents[0]).to be_an_instance_of(Die)
        expect(@player.cup.contents[0].curr_value).to eq(nil)
        expect(@player.cup.contents[1]).to be_an_instance_of(Die)
        expect(@player.cup.contents[1].curr_value).to eq(nil)
        expect(@player.cup.contents[2]).to be_an_instance_of(Die)
        expect(@player.cup.contents[2].curr_value).to eq(nil)
        expect(@player.cup.contents[3]).to be_an_instance_of(Die)
        expect(@player.cup.contents[3].curr_value).to eq(nil)
        expect(@player.cup.contents[4]).to be_an_instance_of(Die)
        expect(@player.cup.contents[4].curr_value).to eq(nil)
        expect(@player.cup.contents[5]).to be_an_instance_of(Die)
        expect(@player.cup.contents[5].curr_value).to eq(nil)
      end

      it '@scorecard is a new scorecard object' do
        expect(@player.scorecard).to be_an_instance_of(Scorecard)
        expect(@player.scorecard.total_score).to eq(0)
      end
    end
  end

  describe 'Instance Methods' do
    it 'load() prompts the player to load dice from @in_play and puts them into cup' do
    end

    it 'roll() prompts the player to roll die in @cup.contents and returns the curr_value of each die' do
    end

    it 'score() prompts to score their @in_play dice' do
    end
  end
end
