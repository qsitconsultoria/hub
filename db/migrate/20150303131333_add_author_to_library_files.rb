class AddAuthorToLibraryFiles < ActiveRecord::Migration
  def change
    add_column :library_files, :author, :string
  end
end
