class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.string :url, unique: true
      t.string :image
      t.string :keywords, array: true, default: []
      t.integer :user_id
      t.integer :used_count, default: 0
      t.timestamps null: false
    end
  end
end
