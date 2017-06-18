class Topic < ActiveRecord::Base
  belongs_to :subject
  validates :name, presence: true
  uploads_many :images, thumb: [100, 100]

  after_initialize :set_position

  def self.ordered
    order(:position)
  end

  def self.next(position)
    where('topics.position > ?', position).order(position: :asc)
  end

  def self.previous(position)
    where('topics.position < ?', position).order(position: :desc)
  end

  def set_position
    return unless subject.present?
    return unless subject.topics.any?

    self.position ||= subject.topics.size + 1
  end

  def next
    subject.topics.next(position).first
  end

  def previous
    subject.topics.previous(position).first
  end
end
