module Authenticated
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters, if: :devise_controller?
    # layout :layout
    # helper_method :current_user
  end

  # def current_user
  #   @current_user ||= student_signed_in? ? current_student : current_teacher
  # end

  protected
    # strong parameters for devise
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:name, :avatar]
    end

  private
    # Devise controllers extends from ApplicationController
    # def layout
    #   if defined?(resource_name) and resource_name == :teacher
    #     'admin'
    #   else
    #     'application'
    #   end
    # end

    # Overwriting the sign_in redirect path method
    def after_sign_in_path_for(resource_or_scope)
      return session['user_return_to'] if session['user_return_to'].present?

      if defined? session[:return_to]
        if session[:return_to].ends_with? 'admin'
          if can? :access_units_index, :admin
            return admin_units_url
          elsif can? :access_courses_index, :admin
            return admin_unit_url(current_user.units.first)
          else
            unit_course_url(Unit.first, Course.first)
          end
        elsif params[:controller] == "devise/passwords"
          unit_url(Unit.first)
        else
          return session[:return_to]
        end
      else
        unit_course_url(Unit.first, Course.first)
      end
    end

    # Overwriting the sign_out redirect path method
    def after_sign_out_path_for(resource_or_scope)
      if params[:from] == 'admin'
        session['user_return_to'] = admin_root_path
      end

      new_user_session_url
    end

    # def authenticate!
    #   authenticate_student! unless student_signed_in? or teacher_signed_in?
    # end
end
