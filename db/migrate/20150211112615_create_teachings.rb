class CreateTeachings < ActiveRecord::Migration
  def change
    create_table :teachings do |t|
      t.integer :course_id
      t.integer :teacher_id
    end
  end
end
