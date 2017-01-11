class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id, null: false
      t.integer :oponent_id, null: false
      t.integer :user_score
      t.integer :oponent_score
      t.date :date_played
      t.timestamps null: false
    end
  end
end
