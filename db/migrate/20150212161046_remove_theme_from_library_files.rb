class RemoveThemeFromLibraryFiles < ActiveRecord::Migration
  def change
    remove_column :library_files, :theme, :string
  end
end
