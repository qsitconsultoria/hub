class Admin::Library::LanguagesController < Admin::AdminController
  def index
    @languages = LibraryFile.pluck(:language).uniq.delete_if { |v| v.nil? || v.empty? }.sort
  end

  def show
    @language = LibraryFile::Language::OPTIONS[params[:id]]

    @files = LibraryFile.where(language: @language).page(params[:page]).per(10)
  end
end
