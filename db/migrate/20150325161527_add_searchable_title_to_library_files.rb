class AddSearchableTitleToLibraryFiles < ActiveRecord::Migration
  def change
    add_column :library_files, :searchable_title, :string
  end
end
