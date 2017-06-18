class AddSlugToLibraryFiles < ActiveRecord::Migration
  def change
    add_column :library_files, :slug, :string
  end
end
