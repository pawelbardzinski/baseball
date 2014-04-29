require 'spec_helper'

describe Batting do
	it 'has 7910 records' do
		expect(Batting.count == 7910)
	end

	it 'has the most improved batting from 2009 to 2010 to be player_id == woodbr01 with percentage increase of 50.9' do
		expect(Batting.most_improved_batting_average(2010, 2011).last == {:player_id=>"woodbr01", :percentage_increase=>50.9})
	end

	it 'has the slugging percentage for team SEA in 2009 to be player_id == "branyru01" with slugging_percentage of 0.52' do
		expect(Batting.slugging_percentage("SEA",2009).last == {:player_id=>"branyru01", :slugging_percentage=>0.52})
	end
end