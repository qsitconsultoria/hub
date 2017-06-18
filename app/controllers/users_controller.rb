class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: :show

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if user_params[:password].blank?
      @user.update_without_password(user_params_without_password)
    else
      @user.update(user_params)
    end

    render 'edit'
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(model_name).permit(:name, :email, :password, :password_confirmation, :avatar, :unit_id, :is_public_server, :works_on, :scholarity_level, :field_of_operation)
    end

    def user_params_without_password
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
      user_params
    end

    def model_name
      @user.class.name.underscore.to_sym
    end
end
