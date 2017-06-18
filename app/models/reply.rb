class Reply < ActiveRecord::Base
  belongs_to :forum_post
  belongs_to :user
end
