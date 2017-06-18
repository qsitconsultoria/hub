class Admin::Library::YearsController < Admin::AdminController
  def index
    @years = LibraryFile.pluck(:year).uniq.delete_if { |v| v.nil? }.sort.reverse
  end

  def show
    @year = params[:id].to_i
    @files = LibraryFile.where(year: @year).page(params[:page]).per(10)
  end
end
