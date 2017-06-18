class RenameForumThreadItemsToForumPosts < ActiveRecord::Migration
  def change
    rename_table :forum_thread_items, :forum_posts
  end
end
