class RemoveRegionFromLibraryFiles < ActiveRecord::Migration
  def change
    remove_column :library_files, :region
  end
end
