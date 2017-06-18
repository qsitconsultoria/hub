class Admin::Library::ThemesController < Admin::AdminController
  def index
    @themes = Theme.ordered.with_files
  end

  def show
    @theme = Theme.friendly.find(params[:id])
    @files = @theme.library_files.page(params[:page]).per(10)
  end
end
