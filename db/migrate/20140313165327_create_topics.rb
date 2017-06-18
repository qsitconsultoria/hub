class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.string :slug, index: true
      t.text :content
      t.belongs_to :subject, index: true

      t.timestamps
    end
  end
end
