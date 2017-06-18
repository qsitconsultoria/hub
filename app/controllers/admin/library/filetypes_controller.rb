class Admin::Library::FiletypesController < Admin::AdminController
  def index
    @filetypes = LibraryFile.pluck(:filetype).uniq.sort.delete_if { |v| v.empty? }
  end

  def show
    @type = LibraryFile::Filetype::OPTIONS[params[:id]]

    @files = LibraryFile.where(filetype: @type).page(params[:page]).per(10)
  end
end
