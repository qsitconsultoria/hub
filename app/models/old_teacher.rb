class OldTeacher < ActiveRecord::Base
  self.table_name = 'teachers'
  include Authenticable
  include UserProfiled
end