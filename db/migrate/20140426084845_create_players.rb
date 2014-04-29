class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :player_id
      t.integer :year_of_birth
      t.string :first_name
      t.string :last_name
      t.timestamps
    end
  end
end
