class AddOriginalFileFilenameToLibraryFiles < ActiveRecord::Migration
  def change
    add_column :library_files, :original_file_filename, :string
  end
end
