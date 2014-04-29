# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

=begin
require 'csv'

CSV.foreach('db/Batting-07-12.csv', headers: true, col_sep: ',', row_sep: "\r", encoding: 'utf-8', skip_blanks: true) do |row|
	Player.create(
		player_id: row[0],
		year_of_birth: row[1],
		first_name: row[2],
		last_name: row[3]
	)
end
=end

f = File.open('db/Master-small.csv').read
fields=f.split("\r")
fields.shift
fields.each do |field|
	row = field.split(',')
	Player.create(
		player_id: row[0],
		year_of_birth: row[1],
		first_name: row[2],
		last_name: row[3]
	)	
end

f = File.open('db/Batting-07-12.csv').read
fields=f.split("\r")
fields.shift
fields.each do |field|
	row = field.split(',')
	Batting.create(
		player_id: row[0],
		year_id: row[1],
		league: row[2],
		team_id: row[3],
		g: row[4] ? row[4] : 0,
		ab: row[5] ? row[5] : 0,
		r: row[6] ? row[6] : 0,
		h: row[7] ? row[7] : 0,
		b2: row[8] ? row[8] : 0,
		b3: row[9] ? row[9] : 0,
		hr: row[10] ? row[10] : 0,
		rbi: row[11] ? row[11] : 0,
		sb: row[12] ? row[12] : 0,
		cs: row[13] ? row[13] : 0
	)	
end
