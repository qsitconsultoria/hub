class Course < ActiveRecord::Base
  extend FriendlyId

  belongs_to :unit

  has_one :forum

  has_many :subjects, dependent: :destroy

  has_many :teachings
  has_many :teachers, through: :teachings

  has_many :enrollments
  has_many :students, through: :enrollments, source: :user

  has_many :links, -> { uniq }, through: :subjects

  has_and_belongs_to_many :library_files

  validates :name, :slug, presence: true
  validates :name, :slug, uniqueness: {scope: :unit}

  friendly_id :slug, use: :history

  before_validation :ensure_slug

  after_create :create_forum

  def self.find_by_teacher(teacher)
    includes(:users).where(users: { id: teacher.id })
  end

  def self.with_files
    includes(:library_files).where.not( library_files: { id: nil })
  end

  def ensure_slug
    if name.present? and slug.blank?
      self.slug = name.parameterize
    end
  end

  protected
    def create_forum
      Forum.create!(name: self.name, description: self.subname, course: self)
    end
end
