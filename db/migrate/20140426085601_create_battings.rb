class CreateBattings < ActiveRecord::Migration
  def change
    create_table :battings do |t|
      t.string :player_id
      t.integer :year_id
      t.string :league
      t.string :team_id
      t.integer :g
      t.integer :ab
      t.integer :r
      t.integer :h
      t.integer :b2
      t.integer :b3
      t.integer :hr
      t.integer :rbi
      t.integer :sb
      t.integer :cs
      t.timestamps
    end
  end
end
