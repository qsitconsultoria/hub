class Managers::InvitationsController < Devise::InvitationsController
  before_action :sign_out_current_user

  layout 'manager_invitation'

  def edit
    @unit = resource.units.first
    super
  end

  protected
    # strong parameters for devise
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:accept_invitation) << [:name, :avatar]
    end

    def after_accept_path_for(resource)
      admin_unit_url(resource.units.first)
    end

  private
    def sign_out_current_user
      sign_out(:user) if current_user.present?
    end
end
