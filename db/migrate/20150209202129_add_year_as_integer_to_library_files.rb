class AddYearAsIntegerToLibraryFiles < ActiveRecord::Migration
  def change
    add_column :library_files, :year, :integer
  end
end
