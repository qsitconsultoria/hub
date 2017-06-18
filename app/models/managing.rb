class Managing < ActiveRecord::Base
  self.table_name = 'units_managers'

  belongs_to :unit
  belongs_to :manager, class_name: 'Manager', foreign_key: 'manager_id'
end
