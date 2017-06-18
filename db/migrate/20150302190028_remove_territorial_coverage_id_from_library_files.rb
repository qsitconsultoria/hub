class RemoveTerritorialCoverageIdFromLibraryFiles < ActiveRecord::Migration
  def change
    remove_column :library_files, :territorial_coverage_id, :integer
  end
end
