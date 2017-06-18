class RenameItemIdToForumPostId < ActiveRecord::Migration
  def change
    rename_column :replies, :item_id, :forum_post_id
  end
end
