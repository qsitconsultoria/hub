class AddTerritorialCoverageToLibraryFiles < ActiveRecord::Migration
  def change
    add_column :library_files, :territorial_coverage, :string
  end
end
