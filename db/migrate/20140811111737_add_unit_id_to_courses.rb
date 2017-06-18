class AddUnitIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :unit_id, :integer
  end
end
