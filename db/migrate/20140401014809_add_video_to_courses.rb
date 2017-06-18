class AddVideoToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :video, :text
  end
end
