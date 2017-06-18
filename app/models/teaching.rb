class Teaching < ActiveRecord::Base
  belongs_to :course
  belongs_to :teacher

  has_many :subjects
end
