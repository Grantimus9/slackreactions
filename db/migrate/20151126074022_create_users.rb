class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :provider
      t.string :email
      t.string :uid
      t.string :role
      t.integer :reactions_count, default: 0

      t.timestamps null: false
    end
  end
end
