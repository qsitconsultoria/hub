class RemoveSubjectsTeachers < ActiveRecord::Migration
  def change
    drop_table :subjects_teachers
  end
end
