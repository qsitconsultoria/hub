class AddProfileFieldsToStudents < ActiveRecord::Migration
  def change
    add_column :users, :works_on, :string
    add_column :users, :scholarity_level, :string
    add_column :users, :field_of_operation, :string
  end
end
