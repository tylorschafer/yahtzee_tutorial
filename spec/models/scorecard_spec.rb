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
        expect(@scorecard.upper_section[:aces]).to eq(0)
        expect(@scorecard.upper_section[:twos]).to eq(0)
        expect(@scorecard.upper_section[:threes]).to eq(0)
        expect(@scorecard.upper_section[:fours]).to eq(0)
        expect(@scorecard.upper_section[:fives]).to eq(0)
        expect(@scorecard.upper_section[:sixes]).to eq(0)
      end

      it '@lower_section is a hash containing all lower section scores' do
        expect(@scorecard.lower_section).to be_an_instance_of(Hash)
        expect(@scorecard.lower_section[:three_of_kind]).to eq(0)
        expect(@scorecard.lower_section[:four_of_kind]).to eq(0)
        expect(@scorecard.lower_section[:full_house]).to eq(0)
        expect(@scorecard.lower_section[:sm_straight]).to eq(0)
        expect(@scorecard.lower_section[:lg_straight]).to eq(0)
        expect(@scorecard.lower_section[:yahtzee]).to eq(0)
        expect(@scorecard.lower_section[:chance]).to eq(0)
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
      xit 'group_finder() finds the count of each die number in play' do
        expect(@scorecard.group_finder(@dice)).to eq({
                                                      1 => 3,
                                                      2 => 1,
                                                      3 => 1,
                                                      5 => 1
                                                    })
      end
      xit 'seq_finder() returns the longest sequence length of the die in play' do
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

    xit 'tally_die() tallies and sums the count of a specified die' do
      @dice[0].curr_value = 1
      @dice[1].curr_value = 2
      @dice[2].curr_value = 3
      @dice[3].curr_value = 4
      @dice[4].curr_value = 5
      @dice[5].curr_value = 1

      expect(@scorecard.tally_die(@dice, 1, 'aces')).to eq(2)
      expect(@scorecard.total_score).to eq(2)
      expect(@scorecard.upper_section[:aces]).to eq(2)

      @dice[0].curr_value = 1
      @dice[1].curr_value = 2
      @dice[2].curr_value = 3
      @dice[3].curr_value = 3
      @dice[4].curr_value = 3
      @dice[5].curr_value = 1

      expect(@scorecard.tally_die(@dice, 3, 'threes')).to eq(9)
      expect(@scorecard.total_score).to eq(9)
      expect(@scorecard.upper_section[:threes]).to eq(11)
    end

    xit 'three_of_kind() verifies there are 3 die of the same number and adds sum of die values to total score' do
      @dice[0].curr_value = 1
      @dice[1].curr_value = 2
      @dice[2].curr_value = 3
      @dice[3].curr_value = 4
      @dice[4].curr_value = 5
      @dice[5].curr_value = 1

      expect(@scorecard.three_of_kind(@dice)).to eq(false)
      expect(@scorecard.total_score).to eq(0)
      expect(@scorecard.lower_section[:three_of_kind]).to eq(0)

      @dice[0].curr_value = 1
      @dice[1].curr_value = 1
      @dice[2].curr_value = 1
      @dice[3].curr_value = 4
      @dice[4].curr_value = 5
      @dice[5].curr_value = 6

      expect(@scorecard.three_of_kind(@dice)).to eq(18)
      expect(@scorecard.total_score).to eq(18)
      expect(@scorecard.lower_section[:three_of_kind]).to eq(18)
    end

    xit 'four_of_kind() verifies there are 3 die of the same number and adds sum of die values to total score' do
      @dice[0].curr_value = 1
      @dice[1].curr_value = 2
      @dice[2].curr_value = 3
      @dice[3].curr_value = 4
      @dice[4].curr_value = 5
      @dice[5].curr_value = 1

      expect(@scorecard.four_of_kind(@dice)).to eq(false)
      expect(@scorecard.total_score).to eq(0)
      expect(@scorecard.lower_section[:four_of_kind]).to eq(0)

      @dice[0].curr_value = 1
      @dice[1].curr_value = 1
      @dice[2].curr_value = 1
      @dice[3].curr_value = 1
      @dice[4].curr_value = 5
      @dice[5].curr_value = 6

      expect(@scorecard.four_of_kind(@dice)).to eq(15)
      expect(@scorecard.total_score).to eq(15)
      expect(@scorecard.lower_section[:four_of_kind]).to eq(15)
    end

    xit 'full_house() returns true and adds 25 points to total_score if there is a full house' do
      @dice[0].curr_value = 1
      @dice[1].curr_value = 1
      @dice[2].curr_value = 1
      @dice[3].curr_value = 1
      @dice[4].curr_value = 5
      @dice[5].curr_value = 6

      expect(@scorecard.full_house(@dice)).to eq(false)
      expect(@scorecard.total_score).to eq(0)
      expect(@scorecard.lower_section[:full_house]).to eq(0)

      @dice[0].curr_value = 1
      @dice[1].curr_value = 1
      @dice[2].curr_value = 2
      @dice[3].curr_value = 2
      @dice[4].curr_value = 3
      @dice[5].curr_value = 3

      expect(@scorecard.full_house(@dice)).to eq(25)
      expect(@scorecard.total_score).to eq(25)
      expect(@scorecard.lower_section[:full_house]).to eq(25)
    end

    xit 'sm_straight() returns true and adds 30 points if there is 4 consecutive die values' do
      @dice[0].curr_value = 1
      @dice[1].curr_value = 1
      @dice[2].curr_value = 2
      @dice[3].curr_value = 2
      @dice[4].curr_value = 3
      @dice[5].curr_value = 3

      expect(@scorecard.sm_straight(@dice)).to eq(false)
      expect(@scorecard.total_score).to eq(0)
      expect(@scorecard.lower_section[:sm_straight]).to eq(0)

      @dice[0].curr_value = 1
      @dice[1].curr_value = 2
      @dice[2].curr_value = 3
      @dice[3].curr_value = 4
      @dice[4].curr_value = 3
      @dice[5].curr_value = 3

      expect(@scorecard.sm_straight(@dice)).to eq(30)
      expect(@scorecard.total_score).to eq(30)
      expect(@scorecard.lower_section[:sm_straight]).to eq(30)
    end

    xit 'lg_straight() returns true and adds 30 points if there is 4 consecutive die values' do
      @dice[0].curr_value = 1
      @dice[1].curr_value = 1
      @dice[2].curr_value = 2
      @dice[3].curr_value = 2
      @dice[4].curr_value = 3
      @dice[5].curr_value = 3

      expect(@scorecard.lg_straight(@dice)).to eq(false)
      expect(@scorecard.total_score).to eq(0)
      expect(@scorecard.lower_section[:lg_straight]).to eq(0)

      @dice[0].curr_value = 1
      @dice[1].curr_value = 2
      @dice[2].curr_value = 3
      @dice[3].curr_value = 4
      @dice[4].curr_value = 5
      @dice[5].curr_value = 3

      expect(@scorecard.lg_straight(@dice)).to eq(40)
      expect(@scorecard.total_score).to eq(40)
      expect(@scorecard.lower_section[:lg_straight]).to eq(40)
    end

    xit 'chance() adds and returns the sum of all dice' do
      @dice[0].curr_value = 1
      @dice[1].curr_value = 2
      @dice[2].curr_value = 3
      @dice[3].curr_value = 4
      @dice[4].curr_value = 5
      @dice[5].curr_value = 3

      expect(@scorecard.chance(@dice)).to eq(18)
      expect(@scorecard.total_score).to eq(18)
      expect(@scorecard.lower_section[:chance]).to eq(18)
    end

    xit 'yahtzee returns true and adds 50 points if there is a yahtzee, on the second yahtzee 100 points are added' do
      @dice[0].curr_value = 1
      @dice[1].curr_value = 2
      @dice[2].curr_value = 3
      @dice[3].curr_value = 4
      @dice[4].curr_value = 5
      @dice[5].curr_value = 3

      expect(@scorecard.yahtzee(@dice)).to eq(false)
      expect(@scorecard.total_score).to eq(0)
      expect(@scorecard.lower_section[:yahtzee]).to eq(0)

      @dice[0].curr_value = 1
      @dice[1].curr_value = 1
      @dice[2].curr_value = 1
      @dice[3].curr_value = 1
      @dice[4].curr_value = 1
      @dice[5].curr_value = 1

      expect(@scorecard.yahtzee(@dice)).to eq(50)
      expect(@scorecard.total_score).to eq(50)
      expect(@scorecard.lower_section[:yahtzee]).to eq(50)

      @dice[0].curr_value = 1
      @dice[1].curr_value = 1
      @dice[2].curr_value = 1
      @dice[3].curr_value = 1
      @dice[4].curr_value = 1
      @dice[5].curr_value = 1

      expect(@scorecard.yahtzee(@dice)).to eq(100)
      expect(@scorecard.total_score).to eq(150)
      expect(@scorecard.lower_section[:yahtzee]).to eq(150)
    end
  end
end
