class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :title
      t.belongs_to :subject, index: true

      t.timestamps
    end
  end
end
