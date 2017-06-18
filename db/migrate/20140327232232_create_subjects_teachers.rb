class CreateSubjectsTeachers < ActiveRecord::Migration
  def change
    create_table :subjects_teachers, id: false do |t|
      t.belongs_to :teacher, index: true
      t.belongs_to :subject, index: true
    end
  end
end
