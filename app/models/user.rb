class User < ActiveRecord::Base
  include Answerable
  include Authenticable
  include UserProfiled

  belongs_to :unit

  has_many :items

  after_initialize :ensure_type

  scope :not_students, -> { where(type: ['Teacher', 'Manager'])}
  scope :teachers, -> { where(type: ['Teacher'])}

  def ensure_type
    self.type ||= 'Student'
  end

  def admin?
    type == 'Admin'
  end

  def manager?
    type == 'Manager'
  end

  def teacher?
    type == 'Teacher'
  end

  def student?
    type == 'Student'
  end
end
