class TerritorialCoverage < ActiveRecord::Base
  extend FriendlyId

  has_and_belongs_to_many :library_files

  friendly_id :slug, use: :history

  before_validation :ensure_slug

  def self.with_files
    includes(:library_files).where.not( library_files: { id: nil })
  end

  def ensure_slug
    if name.present? and slug.blank?
      self.slug = name.parameterize
    end
  end
end
