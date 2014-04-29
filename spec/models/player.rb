require 'spec_helper'

describe Player do
	it 'has 36250 records' do
		expect(Player.count == 36250)
	end
end