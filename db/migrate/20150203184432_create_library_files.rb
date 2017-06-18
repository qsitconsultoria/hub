class CreateLibraryFiles < ActiveRecord::Migration
  def change
    create_table :library_files do |t|
      t.string :title
      t.string :theme
      t.string :region
      t.string :course
      t.string :filetype
      t.string :language
      t.string :year
    end
  end
end
