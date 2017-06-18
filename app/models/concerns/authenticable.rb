module Authenticable
  extend ActiveSupport::Concern

  included do
    devise :registerable, :database_authenticatable,
           :recoverable, :rememberable, :trackable,
           :validatable, :timeoutable
  end
end
