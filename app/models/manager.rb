class Manager < User
  include UserProfiled

  devise :database_authenticatable, :confirmable, :invitable

  has_many :managings
  has_many :units, through: :managings

  scope :confirmed, -> { where.not(invitation_accepted_at: nil) }
  scope :unconfirmed, -> { where(invitation_accepted_at: nil) }

  def self.not_in_unit(unit)
    where.not(id: unit.manager_ids)
  end

  def self.find_by_email(email)
    where(email: email).first
  end
end
