class AddViewsCountToForumThread < ActiveRecord::Migration
  def change
    add_column :forum_threads, :views_count, :integer, default: 0
  end
end
