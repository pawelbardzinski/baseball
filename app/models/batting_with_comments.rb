class Batting_ < ActiveRecord::Base

	# Calculate the most improved batting average from year to year:
	def self.most_improved_batting_average(start_year, end_year)
		@most_improved_batting_average = []
		# Using sql to increase performance... get all records stored in battings table from the start_year 
		# and with players who had at least 200 at-bats:
		records_from_start_date = Batting.find_by_sql("select * from battings where year_id=#{start_year} and ab > 199") 
		records_from_start_date.each do |start_record|
			# Per each records in batting from start_date find a corresponding record for the end_date:
			end_date_records = Batting.find_by_sql("select * from battings where player_id = \"#{start_record.player_id}\" and year_id = #{end_year} and ab > 199")
			# If no records found continue with the next iteration of the loop
			next if end_date_records.empty?
			# Extract the corresponding end_date record from the results array:
			end_record = end_date_records.first
			# Calculate batting averages:
			start_batting_average = start_record.h.to_f / start_record.ab.to_f
			end_batting_average = end_record.h.to_f / end_record.ab.to_f
			# Start next iteration if there was no improvement in batting average for that player:
			next if start_batting_average > end_batting_average
			# Caluclate how many percent better the player was in the end_year compared to the start_year:
			percent_better = (((end_batting_average - start_batting_average) / start_batting_average) * 100).round(2)
			# Store player_id and percentage increase in batting average as a hash in an array:
			@most_improved_batting_average << {player_id: start_record.player_id, percentage_increase: percent_better}
		end
		# Sort the array by the percentage increase in the batting average:
		@most_improved_batting_average.sort_by { |hash| hash[:percentage_increase]} 
		# The line above as the last line of code in the method will be returned as the method's value
	end

	# Calculate slugging percentage for a team in a given year
	def self.slugging_percentage(team, year)
		@players_slugging_percentage = []
		# Get all records from the battings table for the given year and team:
		records = Batting.find_by_sql("select * from battings where team_id = \"#{team}\" and year_id = #{year}")
		records.each do |record|
			# Calculate the slugging percentage for each record:
			slugging_percentage = ((record.h - record.b2 - record.b3 - record.hr) + (2 * record.b2) + (3 * record.b3) + (4 * record.hr)).to_f / record.ab.to_f unless record.ab == 0
			# Add a hash with player_id and the corresponding slugging percentage to an array:
			@players_slugging_percentage << {player_id: record.player_id, slugging_percentage: slugging_percentage.round(2)} unless slugging_percentage == nil
		end
		# Sort and return the array:
		@players_slugging_percentage.sort_by { |hash| hash[:slugging_percentage]}
	end

	# Check if there was a triple crown winner for a given year and league
	def self.triple_crown_winner(league, year)
		# Get the records using SQL:
		records = Batting.find_by_sql("select * from battings where year_id = #{year} and league = \"#{league}\"")
		# Triple Crown Winner has the best BA, best HR and highest RBI in a given year and league:
		# Setup empty arrays to store sorted records for the best BA, HR, and RBI:
		@batting_averages = []
		@home_runs = []
		@rbis = []
		# Get all BA, HR and RBI for a league in the given year:
		records.each do |record|
			@batting_averages << {player_id: record.player_id, batting_average: (record.h.to_f / record.ab.to_f).round(2)} unless record.ab == 0 || record.h == 0
			@home_runs << {player_id: record.player_id, home_runs: record.hr}
			@rbis << {player_id: record.player_id, rbi: record.rbi}
		end
		# Sort to get the highest BA, HR, and RBI and store them in variables:
		@highest_batting_average = @batting_averages.sort_by { |hash| hash[:batting_average]}.last
		@most_home_runs = @home_runs.sort_by { |hash| hash[:home_runs]}.last
		@most_rbis = @rbis.sort_by { |hash| hash[:rbi]}.last
		# Check if the same player_id has the highest BA, HR, and RBI. If yes return player_id. Return '' if not
		if (@most_rbis[:player_id] == @most_home_runs[:player_id]) == @highest_batting_average[:player_id]
			@most_rbis[:player_id]
		else
			''
		end
	end
end
