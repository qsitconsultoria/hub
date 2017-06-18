class Unit < ActiveRecord::Base
  extend FriendlyId

  COLORS = ['orange', 'light-green', 'dark-green', 'water-blue', 'sky-blue',
            'ocean-blue', 'purple', 'red', 'gray', 'dark']

  has_many :courses

  has_many :managings
  has_many :managers, through: :managings

  has_many :users

  uploads_one :logo, thumb: [35, 35], regular: [140, 140], placeholder: 'unit_logo.png'

  validates :name, presence: true, uniqueness: true

  friendly_id :slug, use: :history

  before_validation :ensure_slug

  def teachers_and_managers
    managers + users.teachers
  end

  def ensure_slug
    if name.present? and slug.blank?
      self.slug = name.parameterize
    end
  end

  def add_manager_and_notify(manager)
    managers << manager
    ManagerMailer.notify(manager).deliver!
  end

  def send_invitation_or_add_manager(params)
    manager = Manager.find_by_email(params[:email])

    if manager
      add_manager_and_notify(manager)
    else
      Manager.invite!(params.merge(units: [self]))
    end
  end
end
