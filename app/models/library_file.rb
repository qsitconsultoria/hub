class LibraryFile < ActiveRecord::Base
  extend FriendlyId
  include Filetype
  include Language
  include ActionView::Helpers::DateHelper
  include Rails.application.routes.url_helpers

  YEARS = (1950..Time.now.year).to_a.reverse

  has_and_belongs_to_many :biomes
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :territorial_coverages
  has_and_belongs_to_many :themes

  has_many :comments, dependent: :destroy

  validates :title, :slug, :filetype, :original_file, presence: true

  friendly_id :slug, use: :history

  before_validation :ensure_slug
  before_save :generate_searchable_title

  scope :ordered, -> { order('created_at DESC') }
  scope :ordered_by_name, -> { order('slug') }

  attachment :original_file

  def self.filetypes
    Filetype::OPTIONS.values
  end

  def self.languages
    Language::OPTIONS.values
  end

  def self.authors
    pluck(:author).uniq.delete_if { |v| v.nil? || v.empty? }
  end

  def ensure_slug
    if title.present? and slug.blank?
      self.slug = title.parameterize
    end
  end

  def generate_searchable_title
    self.searchable_title = ActiveSupport::Inflector.transliterate(title)
  end

  def url
    library_file_path(self)
  end

  def filetype_icon_url
    ActionController::Base.helpers.asset_path("file-icons/ico-#{self.filetype.parameterize}-small.png")
  end

  def as_json(options={})
    { url: url, title: self.title, filetype: self.filetype, filetype_icon: self.filetype_icon_url, created_at: time_ago_in_words(self.created_at) }
  end
end
