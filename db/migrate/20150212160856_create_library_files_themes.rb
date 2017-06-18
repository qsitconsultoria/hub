class CreateLibraryFilesThemes < ActiveRecord::Migration
  def change
    create_table :library_files_themes, id: false do |t|
      t.belongs_to :library_file
      t.belongs_to :theme
    end
  end
end
