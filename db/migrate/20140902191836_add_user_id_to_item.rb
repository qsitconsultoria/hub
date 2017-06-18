class AddUserIdToItem < ActiveRecord::Migration
  def change
    add_column :forum_items, :user_id, :integer
  end
end
