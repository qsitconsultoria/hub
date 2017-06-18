class RenameAdminUsersToTeachers < ActiveRecord::Migration
  def change
    rename_table :admin_users, :teachers
  end
end
