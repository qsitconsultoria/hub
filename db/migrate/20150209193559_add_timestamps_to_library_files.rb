class AddTimestampsToLibraryFiles < ActiveRecord::Migration
  def change
    change_table :library_files do |t|
      t.timestamps
    end
  end
end
