class AddVideoToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :video, :text
  end
end
