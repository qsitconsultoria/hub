class Subject < ActiveRecord::Base
  extend FriendlyId

  belongs_to :course
  has_many :topics, dependent: :destroy

  has_and_belongs_to_many :links
  has_one :question

  validates :name, :slug, presence: true
  validates :name, :slug, uniqueness: {scope: :course}

  friendly_id :slug, use: :history

  before_validation :ensure_slug
  after_initialize :set_position

  def self.ordered
    order(:position)
  end

  def self.next(position)
    where('subjects.position > ?', position).order(position: :asc)
  end

  def self.previous(position)
    where('subjects.position < ?', position).order(position: :desc)
  end

  def ensure_slug
    if name.present? and slug.blank?
      self.slug = name.parameterize
    end
  end

  def set_position
    return unless course.present?

    self.position ||= course.subjects.size + 1
  end

  def active?
    published_at.to_date <= Date.today
  end

  def inactive?
    !active?
  end

  def next
    course.subjects.next(position).first
  end

  def previous
    course.subjects.previous(position).first
  end
end
