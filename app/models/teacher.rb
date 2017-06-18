class Teacher < User
  include UserProfiled

  has_many :teachings
  has_many :courses, through: :teachings
  has_many :subjects, through: :teachings
  has_many :units, through: :courses

  def self.ordered
    order(:name)
  end
end
