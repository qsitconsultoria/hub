module UserProfiled
  extend ActiveSupport::Concern

  included do
    uploads_one :avatar, thumb: [36, 36], regular: [100, 100], placeholder: 'avatar.jpg'
    validates :name, presence: true
  end

  def first_name
    name.split(' ').first
  end
end