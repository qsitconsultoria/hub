class ForumPost < ActiveRecord::Base
  belongs_to :forum_thread
  belongs_to :user

  has_many :replies, dependent: :destroy
end
