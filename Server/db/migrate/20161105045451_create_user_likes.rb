class CreateUserLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :user_likes do |t|
      t.integer :user_id
      t.integer :to_user_id
      t.timestamps
    end
  end
end
