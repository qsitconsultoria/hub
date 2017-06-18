class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :content

      t.belongs_to :item, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
