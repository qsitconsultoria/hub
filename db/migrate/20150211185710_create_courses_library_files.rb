class CreateCoursesLibraryFiles < ActiveRecord::Migration
  def change
    create_table :courses_library_files, id: false do |t|
      t.belongs_to :course
      t.belongs_to :library_file
    end
  end
end
