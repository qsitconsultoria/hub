class Admin::ManagersController < Admin::AdminController
  before_action :set_manager, only: [:edit, :update, :destroy]

  def index
    @title = "Gestores"
    @unit = Unit.friendly.find(params[:unit_id])
    @managers = @unit.managers
  end

  def new
    @unit = Unit.friendly.find(params[:unit_id])
    @available_managers = Manager.confirmed.not_in_unit(@unit)
    @manager = Manager.new
  end

  def edit
  end

  def create
    @unit = Unit.friendly.find(params[:unit_id])

    if params[:manager][:name].blank?
      @unit.add_manager_and_notify(Manager.find(params[:manager][:id]))
    else
      @unit.send_invitation_or_add_manager(manager_params)
    end

    redirect_to admin_unit_managers_url
  end

  def update
    if manager_params[:password].blank?
      @manager.update_without_password(manager_params_without_password)
    else
      @manager.update(manager_params)
    end

    if @manager.valid?
      redirect_to admin_unit_managers_url(@unit)
    else
      render action: 'edit'
    end
  end


  def destroy
    @unit = Unit.friendly.find(params[:unit_id])
    @unit.managers.delete(@manager)
    
    redirect_to admin_unit_managers_url
  end

  private
    def set_manager
      @manager = Manager.find(params[:id])
    end

    def manager_params
      params.require(:manager).permit(:id, :name, :email, :unit_id, :password, :password_confirmation, :avatar)
    end

    def manager_params_without_password
      manager_params.delete(:password)
      manager_params.delete(:password_confirmation)
      manager_params
    end
end
