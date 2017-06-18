class ApplicationController < ActionController::Base
  include Authenticated

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_current_unit
  before_action :set_current_course
  before_filter :store_return_to

  rescue_from CanCan::AccessDenied do
    redirect_to permission_denied_url
  end

  def store_return_to
    unless request.referrer.nil?
      unless request.referrer.ends_with? 'login'
        session[:return_to] = request.referrer
      end
    end
  end

  protected
    # strong parameters for devise
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:name, :avatar]
    end

  private
    def set_current_unit
      @unit ||= if params[:unit_id].present?
        Unit.friendly.find(params[:unit_id])
      else
        Unit.first
      end
    end

    def set_current_course
      @course ||= if params[:course_id].present?
        @unit.courses.friendly.find(params[:course_id])
      else
        Course.first
      end
    end
end
