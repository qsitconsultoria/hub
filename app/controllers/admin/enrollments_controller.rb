class Admin::EnrollmentsController < Admin::AdminController
  before_action :set_enrollment, only: [:show]
  before_action :set_enrollment_for_status_update, only: [:approve, :reject]

  def index
    @waiting_for_approval = @course.enrollments.waiting
    @approved = @course.enrollments.approved
    @rejected = @course.enrollments.rejected
  end

  def show
  end

  def approve
    @enrollment.approve!

    if @enrollment.save
      StudentMailer.enrollment_approved(@enrollment.student, @enrollment.course).deliver!
      redirect_to admin_unit_course_enrollments_url(@unit, @course)
    else
      render 'show'
    end
  end

  def reject
    @enrollment.reject!

    if @enrollment.save
      StudentMailer.enrollment_rejected(@enrollment.student, @enrollment.course).deliver!
      redirect_to admin_unit_course_enrollments_url(@unit, @course)
    else
      render 'show'
    end
  end

  def ignored
    @rejected = @course.enrollments.rejected
  end

  private
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    def set_enrollment_for_status_update
      @enrollment = Enrollment.find(params[:enrollment_id])
    end
end
