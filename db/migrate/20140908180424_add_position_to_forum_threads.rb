class AddPositionToForumThreads < ActiveRecord::Migration
  def change
    add_column :forum_threads, :position, :string
  end
end
