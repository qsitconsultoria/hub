class Users::RegistrationsController < Devise::RegistrationsController
  private
    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :unit_id)
    end
end
