class RenameUserIdToStudentIdOnEnrollments < ActiveRecord::Migration
  def change
    rename_column :enrollments, :user_id, :student_id

    add_index :enrollments, [:course_id, :student_id], unique: true
  end
end
