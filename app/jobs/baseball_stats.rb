class BaseballStats
	def initialize
		@logger = Rails.logger
	end

	def run_all
		self.most_improved_batting_average
		self.slugging_percentage
		self.triple_crown_winner
	end

	def most_improved_batting_average
		puts '-' * 50
		puts 'Players with the highest increase in batting average from 2009 to 2010:'
		best_batting_avg_2009_2010 = Batting.most_improved_batting_average(2009,2010)
		best_batting_avg_2009_2010.each do |record|
			player = Player.find_by_sql("select * from players where player_id = \"#{record[:player_id]}\"").first
			puts "#{player[:first_name]} #{player[:last_name]}: #{record[:percentage_increase]}"
		end
	end

	def slugging_percentage
		puts '-' * 50
		@logger.info 
		puts 'Slugging percentage for OAK players in 2007:'
		slugging_percentage_oak_2007 = Batting.slugging_percentage("OAK",2007)
		slugging_percentage_oak_2007.each do |record|
			player = Player.find_by_sql("select * from players where player_id = \"#{record[:player_id]}\"").first
			puts "#{player[:first_name]} #{player[:last_name]}: #{record[:slugging_percentage]}"
		end
	end

	def triple_crown_winner
		puts '-' * 50
		puts 'AL and NL triple crown winners in 2011 and 2012:'
		al_2011_tcw = Batting.triple_crown_winner('AL',2011)
		nl_2011_tcw = Batting.triple_crown_winner('NL',2011)
		al_2012_tcw = Batting.triple_crown_winner('AL',2012)
		nl_2012_tcw = Batting.triple_crown_winner('NL',2012)
		puts "AL in 2011:"
		if al_2011_tcw.empty?
			puts '(No winner)'
		else
			player = Player.find_by_sql("select * from players where player_id = \"#{record[:player_id]}\"").first
			puts "#{player[:first_name]} #{player[:last_name]} was Triple Crown Winner in 2011 for AL league"
		end
		puts "NL in 2011:"
		if nl_2011_tcw.empty?
			puts '(No winner)'
		else
			player = Player.find_by_sql("select * from players where player_id = \"#{record[:player_id]}\"").first
			puts "#{player[:first_name]} #{player[:last_name]} was Triple Crown Winner in 2011 for NL league"
		end
		puts "AL in 2012:"
		if al_2012_tcw.empty?
			puts '(No winner)'
		else
			player = Player.find_by_sql("select * from players where player_id = \"#{record[:player_id]}\"").first
			puts "#{player[:first_name]} #{player[:last_name]} was Triple Crown Winner in 2012 for AL league"
		end
		puts "NL in 2012:"
		if nl_2012_tcw.empty?
			puts '(No winner)'
		else
			player = Player.find_by_sql("select * from players where player_id = \"#{record[:player_id]}\"").first
			puts "#{player[:first_name]} #{player[:last_name]} was Triple Crown Winner in 2012 for NL league"
		end
	end

end