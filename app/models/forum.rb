class Forum < ActiveRecord::Base
  belongs_to :course
  has_many :threads, class_name: "ForumThread"
end
