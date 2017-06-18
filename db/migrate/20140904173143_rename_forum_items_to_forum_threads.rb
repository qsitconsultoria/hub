class RenameForumItemsToForumThreads < ActiveRecord::Migration
  def change
    rename_table :forum_items, :forum_threads
  end
end
