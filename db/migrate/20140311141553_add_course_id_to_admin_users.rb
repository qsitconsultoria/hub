class AddCourseIdToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :course_id, :integer
    add_index :admin_users, :course_id
  end
end
