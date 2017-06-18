class Admin::TeachersController < Admin::AdminController
  before_action :set_teacher, only: [:edit, :update, :destroy]

  def index
    @teachers = @course.teachers
  end

  def new
    @teacher = Teacher.new
  end

  def edit
  end

  def create
    @teacher = Teacher.new(teacher_params.merge(unit: @unit))

    if @teacher.save
      Teaching.create! course: @course, teacher: @teacher
      redirect_to admin_unit_course_teachers_url(@unit, @course)
    else
      render action: 'new'
    end
  end

  def update
    if teacher_params[:password].blank?
      @teacher.update_without_password(teacher_params_without_password)
    else
      @teacher.update(teacher_params)
    end

    if @teacher.valid?
      if @teacher == current_user
        sign_in(@teacher, bypass: true)
      end

      redirect_to admin_unit_course_teachers_url(@unit, @course)
    else
      render action: 'edit'
    end
  end

  def destroy
    @teacher.destroy
    redirect_to admin_unit_course_teachers_url(@unit, @course)
  end

  private
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    def teacher_params
      params.require(:teacher).permit(:name, :email, :password, :password_confirmation, :avatar, :biography)
    end

    def teacher_params_without_password
      teacher_params.delete(:password)
      teacher_params.delete(:password_confirmation)
      teacher_params
    end
end
