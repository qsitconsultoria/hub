class OldStudent < ActiveRecord::Base
  self.table_name = 'students'

  include Authenticable
end