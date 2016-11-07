class CreateBibles < ActiveRecord::Migration[5.0]
  def change
    create_table :bibles, {:id => false} do |t|
      t.string :bid, limit: 10
      t.integer :book_id
      t.string :emotion, limit: 5
      t.timestamps
    end
  end
end
