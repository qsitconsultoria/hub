module Rolified
  extend ActiveSupport::Concern

  included do
    after_initialize :init
  end

  def init
    self.role ||= Role.find_or_create_by(name: self.class.name)
  end
end