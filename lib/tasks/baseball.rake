namespace :baseball do 

	desc 'Baseball statistics per requirement'
	task run_all: :environment do
		baseball_stats = BaseballStats.new
		baseball_stats.run_all
	end
	
end