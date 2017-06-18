class Admin::Library::CoursesController < Admin::AdminController
  def index
    @courses = Course.with_files
  end

  def show
    @course = Course.friendly.find(params[:id])
    @files = @course.library_files.page(params[:page]).per(10)
  end
end
