class EnrollmentsController < ApplicationController
  def new
    @enrollment = Enrollment.new
    @student = Student.new
  end

  def create
    @student = Student.create(student_params.merge(unit: @unit))

    if @student.save
      @course = Course.friendly.find(params[:course_id])

      @enrollment = Enrollment.create!(course: @course, student: @student)

      StudentMailer.successfully_enrolled(@student, @course).deliver!
      sign_in(@student)
      render 'enrolled'
    else
      @enrollment = Enrollment.new
      render 'new'
    end
  end

  def enroll_student
    @enrollment = Enrollment.create! course: @course, student: current_user

    if @enrollment.save
      StudentMailer.successfully_enrolled(current_user, @course).deliver!
      render 'enrolled'
    else
      redirect_to unit_course_url(@unit, @course)
    end
  end

  def enrolled
  end

  private
    def student_params
      params.require(:enrollment).require(:student).permit(:name, :email, :password, :password_confirmation, :is_public_server, :works_on, :scholarity_level, :field_of_operation)
    end
end
