class Admin::CoursesController < Admin::AdminController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :set_unit, except: [:create]

  def index
  end

  def show
    @students = @course.enrollments.approved
    @subjects = @course.subjects.ordered
    authorize! :see_course_show_page, @course
  end

  def new
    @course = @unit.courses.build
    authorize! :create_new_course, @course
  end

  def edit
    authorize! :edit_course, @course
  end

  def duplicate
    @course = @unit.courses.friendly.find(params[:course_id])
    @course = Course.new(@course.attributes)
  end

  def create
    if params[:course][:unit_id].present?
      @unit = Unit.friendly.find(params[:course][:unit_id])
      @course = Course.friendly.find(params[:course][:slug])

      @course = @course.deep_clone include: {subjects: [:topics, :links, :question]}, except: :unit_id
      @course.unit_id = @unit.id
    else
      @course = @unit.courses.build(course_params)
    end

    if @course.save
      redirect_to admin_unit_course_subjects_url(@unit, @course)
    else
      render action: 'new'
    end
  end

  def update
    if @course.update(course_params)
      redirect_to admin_unit_course_subjects_url(@unit, @course)
    else
      render action: 'edit'
    end
  end

  def destroy
    @course.destroy
    redirect_to admin_unit_url(@unit)
  end

  private
    def set_unit
      @unit = Unit.friendly.find(params[:unit_id])
    end

    def set_course
      @course = @unit.courses.friendly.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :subname, :slug, :video, :unit_id)
    end
end
