class Admin::LinksController < Admin::AdminController
  before_action :set_link, only: [:edit, :update, :destroy]
  before_action :set_subjects
  before_action :set_library_files

  def index
    @links = @course.links
    authorize! :see_links, @course
  end

  def new
    @link = Link.new
    authorize! :create_new_link, @link
  end

  def edit
    authorize! :edit_link, @link
  end

  def create
    if params[:link][:name].blank? && !(params[:library_file].blank?)
      @file = LibraryFile.friendly.find(params[:library_file])

      params[:link][:name] = @file.title
      params[:link][:url] = url_for(@file)
      params[:link][:icon] = @file.filetype.parameterize
    end

    @link = Link.new(link_params)

    if @link.save
      redirect_to admin_unit_course_links_url
    else
      render action: 'new'
    end
  end

  def update
    if @link.update(link_params)
      redirect_to admin_unit_course_links_url
    else
      render action: 'edit'
    end
  end

  def destroy
    @link.destroy
    redirect_to admin_unit_course_links_url
  end

  private
    def set_link
      @link = Link.find(params[:id])
    end

    def link_params
      params.require(:link).permit(:name, :url, :icon, subject_ids: [])
    end

    def set_subjects
      @subjects = @course.subjects
    end

    def set_library_files
      @files = @course.library_files.ordered_by_name
    end
end
