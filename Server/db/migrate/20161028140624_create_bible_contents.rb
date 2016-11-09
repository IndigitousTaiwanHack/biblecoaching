class CreateBibleContents < ActiveRecord::Migration[5.0]
  def change
    create_table :bible_contents do |t|
      t.string :bible_bid, limit: 10
      t.integer :content_id
      t.string :content, limit: 2048
      t.timestamps
    end
  end
end
