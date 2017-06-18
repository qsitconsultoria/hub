class CreateItems < ActiveRecord::Migration
  def change
    create_table :forum_thread_items do |t|
      t.text :content

      t.belongs_to :forum_thread, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
