class RemoveCourseIdFromAdminUsers < ActiveRecord::Migration
  def change
    remove_column :admin_users, :course_id, :integer
  end
end
