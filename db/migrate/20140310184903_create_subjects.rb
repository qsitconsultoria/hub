class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :slug, index: true
      t.text :description
      t.datetime :published_at
      t.belongs_to :course, index: true

      t.timestamps
    end
  end
end
