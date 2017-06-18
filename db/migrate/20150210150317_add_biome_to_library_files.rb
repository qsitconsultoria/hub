class AddBiomeToLibraryFiles < ActiveRecord::Migration
  def change
    add_column :library_files, :biome, :string
  end
end
