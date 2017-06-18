class CreateForumItems < ActiveRecord::Migration
  def change
    create_table :forum_items do |t|
      t.string :title
      t.text :content

      t.belongs_to :forum, index: true

      t.timestamps
    end
  end
end
