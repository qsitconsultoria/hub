class RemoveStringFieldBiomeFromLibraryFiles < ActiveRecord::Migration
  def change
    remove_column :library_files, :biome
  end
end
