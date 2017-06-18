class Admin::Library::AuthorsController < Admin::AdminController
  def index
    @authors = LibraryFile.pluck(:author).uniq.delete_if { |v| v.nil? || v.empty? }.sort
  end

  def show
    @author = params[:id]

    @files = LibraryFile.where(author: @author).page(params[:page]).per(10)
  end
end
