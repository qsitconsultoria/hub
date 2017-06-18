class Comment < ActiveRecord::Base
  belongs_to :library_file
  belongs_to :user

  scope :ordered, -> { order('created_at DESC') }
end
