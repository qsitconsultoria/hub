class RemoveCourseFromLibraryFiles < ActiveRecord::Migration
  def change
    remove_column :library_files, :course, :string
  end
end
