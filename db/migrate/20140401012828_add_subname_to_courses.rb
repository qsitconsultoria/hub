class AddSubnameToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :subname, :string
  end
end
