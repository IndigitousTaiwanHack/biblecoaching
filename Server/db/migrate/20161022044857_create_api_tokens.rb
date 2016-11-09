class CreateApiTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :api_tokens do |t|
      t.string :access_token
      t.timestamps
    end
  end
end
