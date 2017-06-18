class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :name
      t.string :description

      t.belongs_to :course, index: true

      t.timestamps
    end
  end
end
