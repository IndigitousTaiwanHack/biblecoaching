class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title, limit: 10
      t.string :abbr, limit: 3
      t.timestamps
    end
  end
end