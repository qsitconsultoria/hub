class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin_user
  before_action :set_courses

  layout 'admin'

  rescue_from CanCan::AccessDenied do
    redirect_to admin_permission_denied_url
  end

  private
    def set_courses
      @courses = Course.all
    end

    def ensure_admin_user
      authorize! :access, :admin
    end
end
