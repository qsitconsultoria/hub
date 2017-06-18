class Admin::SubjectsController < Admin::AdminController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  def index
    @subjects = @course.subjects.ordered
    authorize! :see_subjects, @course
  end

  def show
  end

  def new
    @subject = @course.subjects.build
    authorize! :create_new_subject, @subject
  end

  def edit
    authorize! :edit_subject, @subject
  end

  def create
    @subject = @course.subjects.build(subject_params)

    if @subject.save
      redirect_to admin_unit_course_subject_topics_url(@unit, @course, @subject)
    else
      render action: 'new'
    end
  end

  def update
    if @subject.update(subject_params)
      redirect_to admin_unit_course_subject_topics_url(@unit, @course, @subject)
    else
      render action: 'edit'
    end
  end

  def destroy
    @subject.destroy
    redirect_to admin_unit_course_subjects_url(@unit, @course)
  end

  private
    def set_subject
      @subject = @course.subjects.friendly.find(params[:id])
    end

    def subject_params
      params.require(:subject).permit(:name, :slug, :description, :published_at, :video, :number, user_ids: [])
    end
end
