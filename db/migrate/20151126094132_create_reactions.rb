class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.string :image
      t.text :keywords
      t.integer :user_id
      t.integer :used_count, default: 0
      t.timestamps null: false
    end
  end
end
