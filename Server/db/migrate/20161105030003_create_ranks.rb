class CreateRanks < ActiveRecord::Migration[5.0]
  def change
    create_table :ranks do |t|
      t.integer :user_id
      t.string :rank_type
      t.integer :object_id
      t.timestamps
    end
  end
end
