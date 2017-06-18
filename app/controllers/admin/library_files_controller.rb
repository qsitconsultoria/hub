class Admin::LibraryFilesController < Admin::AdminController
  before_action :set_file, only: [:edit, :update, :destroy]

  def index
    @q = LibraryFile.ransack(params[:query])

    if params[:query].present?
      @files = @q.result(distinct: true).ordered.page(params[:page]).per(10)
    else
      @library_files = LibraryFile.ordered.limit(5)
    end
  end

  def new
    @file = LibraryFile.new
  end

  def edit
    session[:previous] = request.env['HTTP_REFERER'] unless request.env['HTTP_REFERER'].ends_with? '/edit'
  end

  def create
    @file = LibraryFile.new(file_params)

    if @file.save
      redirect_to admin_library_files_url
    else
      if file_params[:original_file] == "{}"
        @missing_file = true
      end

      render action: 'new'
    end
  end

  def update
    if @file.update(file_params)
      flash[:notice] = 'Arquivo atualizado com sucesso.'
      redirect_to edit_admin_library_file_url(@file)
    else
      render action: 'edit'
    end
  end

  def destroy
    @file.destroy
    redirect_to admin_library_files_url
  end

  private
    def set_file
      @file = LibraryFile.friendly.find(params[:id])
    end

    def file_params
      params.require(:library_file).permit(:original_file, :remove_original_file, :title, :author, :filetype, :language, :year, biome_ids: [], course_ids: [], territorial_coverage_ids: [], theme_ids: [])
    end
end
