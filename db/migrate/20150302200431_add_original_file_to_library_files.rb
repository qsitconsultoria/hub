class AddOriginalFileToLibraryFiles < ActiveRecord::Migration
  def change
    add_column :library_files, :original_file_id, :string
  end
end
