class AddPolymorphicUserToAnswers < ActiveRecord::Migration
  def change
    remove_column :answers, :student_id
    add_column :answers, :answerable_id, :integer
    add_column :answers, :answerable_type, :string
  end
end
