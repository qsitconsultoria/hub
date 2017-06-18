class RemoveYearFromLibraryFiles < ActiveRecord::Migration
  def change
    remove_column :library_files, :year
  end
end
