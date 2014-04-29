class Batting < ActiveRecord::Base

	def self.most_improved_batting_average(start_year, end_year)
		@most_improved_batting_average = []
		records_from_start_date = Batting.find_by_sql("select * from battings where year_id=#{start_year} and ab > 199") 
		records_from_start_date.each do |start_record|
			end_date_records = Batting.find_by_sql("select * from battings where player_id = \"#{start_record.player_id}\" and year_id = #{end_year} and ab > 199")
			next if end_date_records.empty?
			end_record = end_date_records.first
			start_batting_average = start_record.h.to_f / start_record.ab.to_f
			end_batting_average = end_record.h.to_f / end_record.ab.to_f
			next if start_batting_average > end_batting_average
			percent_better = (((end_batting_average - start_batting_average) / start_batting_average) * 100).round(2)
			@most_improved_batting_average << {player_id: start_record.player_id, percentage_increase: percent_better}
		end
		@most_improved_batting_average.sort_by { |hash| hash[:percentage_increase]} 
	end

	def self.slugging_percentage(team, year)
		@players_slugging_percentage = []
		records = Batting.find_by_sql("select * from battings where team_id = \"#{team}\" and year_id = #{year}")
		records.each do |record|
			slugging_percentage = ((record.h - record.b2 - record.b3 - record.hr) + (2 * record.b2) + (3 * record.b3) + (4 * record.hr)).to_f / record.ab.to_f unless record.ab == 0
			@players_slugging_percentage << {player_id: record.player_id, slugging_percentage: slugging_percentage.round(2)} unless slugging_percentage == nil
		end
		@players_slugging_percentage.sort_by { |hash| hash[:slugging_percentage]}
	end

	def self.triple_crown_winner(league, year)
		records = Batting.find_by_sql("select * from battings where year_id = #{year} and league = \"#{league}\"")
		@batting_averages = []
		@home_runs = []
		@rbis = []
		records.each do |record|
			@batting_averages << {player_id: record.player_id, batting_average: (record.h.to_f / record.ab.to_f).round(2)} unless record.ab == 0 || record.h == 0
			@home_runs << {player_id: record.player_id, home_runs: record.hr}
			@rbis << {player_id: record.player_id, rbi: record.rbi}
		end
		@highest_batting_average = @batting_averages.sort_by { |hash| hash[:batting_average]}.last
		@most_home_runs = @home_runs.sort_by { |hash| hash[:home_runs]}.last
		@most_rbis = @rbis.sort_by { |hash| hash[:rbi]}.last
		if (@most_rbis[:player_id] == @most_home_runs[:player_id]) == @highest_batting_average[:player_id]
			@most_rbis[:player_id]
		else
			''
		end
	end
end
