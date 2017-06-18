class RemoveTerritorialCoverageStringFieldFromLibraryFiles < ActiveRecord::Migration
  def change
    remove_column :library_files, :territorial_coverage
  end
end
