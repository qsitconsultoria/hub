class AddBiographyToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :biography, :text
  end
end
