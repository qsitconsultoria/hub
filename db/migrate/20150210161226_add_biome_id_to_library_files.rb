class AddBiomeIdToLibraryFiles < ActiveRecord::Migration
  def change
    add_column :library_files, :biome_id, :integer
  end
end
