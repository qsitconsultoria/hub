class AddTerritorialCoverageIdToLibraryFiles < ActiveRecord::Migration
  def change
    add_column :library_files, :territorial_coverage_id, :integer
  end
end
