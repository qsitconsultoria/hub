class Link < ActiveRecord::Base
  validates :name, presence: true
  validates :url, url: {message: :invalid_url}, allow_blank: true
  validates :subjects, presence: true
  has_and_belongs_to_many :subjects
end
