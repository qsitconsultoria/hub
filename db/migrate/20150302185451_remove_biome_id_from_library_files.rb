class RemoveBiomeIdFromLibraryFiles < ActiveRecord::Migration
  def change
    remove_column :library_files, :biome_id, :integer
  end
end
