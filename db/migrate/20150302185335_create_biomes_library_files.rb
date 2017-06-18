class CreateBiomesLibraryFiles < ActiveRecord::Migration
  def change
    create_table :biomes_library_files, id: false do |t|
      t.belongs_to :biome
      t.belongs_to :library_file
    end
  end
end
