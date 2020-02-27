require './spec/spec_helper'

RSpec.describe 'Scorecard' do

  before :each do
    @scorecard = Scorecard.new()
    @dice = []
    6.times do
      @dice << Die.new()
    end
  end

  describe 'Instantiation' do
    it 'Can Exist' do
      expect(@scorecard).to be_an_instance_of(Scorecard)
    end

    describe 'Attributes' do
      it '@total_score starts 0' do
        expect(@scorecard.total_score).to eq(0)
      end

      it '@upper_section is a hash containing all upper section scores' do
        expect(@scorecard.upper_section).to be_an_instance_of(Hash)
        expect(@scorecard.upper_section.aces).to eq(0)
        expect(@scorecard.upper_section.twos).to eq(0)
        expect(@scorecard.upper_section.threes).to eq(0)
        expect(@scorecard.upper_section.fours).to eq(0)
        expect(@scorecard.upper_section.fives).to eq(0)
        expect(@scorecard.upper_section.sixes).to eq(0)
      end

      it '@lower_section is a hash containing all lower section scores' do
        expect(@scorecard.lower_section).to be_an_instance_of(Hash)
        expect(@scorecard.lower_section.three_of_kind).to eq(0)
        expect(@scorecard.lower_section.four_of_kind).to eq(0)
        expect(@scorecard.lower_section.full_house).to eq(0)
        expect(@scorecard.lower_section.sm_straight).to eq(0)
        expect(@scorecard.lower_section.lg_straight).to eq(0)
        expect(@scorecard.lower_section.yahtzee).to eq(0)
        expect(@scorecard.lower_section.chance).to eq(0)
      end
    end
  end

  describe 'Instance m\Methods' do
    describe 'Helper Methods' do
      before :each do
        @dice[0].curr_value = 1
        @dice[1].curr_value = 1
        @dice[2].curr_value = 1
        @dice[3].curr_value = 2
        @dice[4].curr_value = 3
        @dice[5].curr_value = 5
      end
      it 'group_finder() finds the count of each die number in play' do
        expect(@scorecard.group_finder(@dice)).to eq({
                                                      1 => 3,
                                                      2 => 1,
                                                      3 => 1,
                                                      5 => 1
                                                    })
      end
      it 'seq_finder() returns the longest sequence length of the die in play' do
         expect(@scorecard.seq_finder(@dice)).to eq(3)

         @dice[0].curr_value = 1
         @dice[1].curr_value = 2
         @dice[2].curr_value = 3
         @dice[3].curr_value = 4
         @dice[4].curr_value = 5
         @dice[5].curr_value = 1

         expect(@scorecard.seq_finder(@dice)).to eq(5)
      end
    end
  end
end
