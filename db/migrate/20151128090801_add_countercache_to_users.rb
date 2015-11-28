class AddCountercacheToUsers < ActiveRecord::Migration
  def up
    add_column :users, :reactions_count, :integer, default: 0
  end
  def down
    remove_column :users, :reactions_count
  end
end
