class CreateLibraryFilesTerritorialCoverages < ActiveRecord::Migration
  def change
    create_table :library_files_territorial_coverages, id: false do |t|
      t.belongs_to :library_file
      t.belongs_to :territorial_coverage
    end
  end
end
