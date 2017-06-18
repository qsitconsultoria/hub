class ForumThread < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user

  has_many :forum_posts

  after_initialize :set_position

  def self.ordered
    order(:position)
  end

  def posts
    forum_posts
  end

  def self.next(position)
    where('forum_threads.position > ?', position).order(position: :asc)
  end

  def self.previous(position)
    where('forum_threads.position < ?', position).order(position: :desc)
  end

  def set_position
    self.position ||= forum.threads.size + 1
  end
end
