class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :text
      t.boolean :matched
      t.string :requesting_user
      t.timestamps null: false
    end
  end
end
