class CreateUnitsManagers < ActiveRecord::Migration
  def change
    create_table :units_managers, id: false do |t|
      t.belongs_to :unit, index: true
      t.belongs_to :manager, index: true
    end
  end
end
