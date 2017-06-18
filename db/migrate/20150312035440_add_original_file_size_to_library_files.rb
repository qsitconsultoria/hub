class AddOriginalFileSizeToLibraryFiles < ActiveRecord::Migration
  def change
    add_column :library_files, :original_file_size, :integer
  end
end
