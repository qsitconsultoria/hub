class Admin::UnitsController < Admin::AdminController
  before_action :set_unit, only: [:edit, :update, :destroy]
  before_action :set_unit_courses, only: [:show]

  def index
    @title = "Configurações"
    @units = current_user.units
    authorize! :access_units_index, :admin
  end

  def show
    @title = "Cursos"
    authorize! :see_unit_show_page, @unit
  end

  def new
    @unit = Unit.new
  end

  def edit
    @title = "Configurações"
  end

  def create
    @unit = Unit.new(unit_params)

    if @unit.save
      redirect_to new_admin_unit_manager_url(@unit)
    else
      render action: 'new'
    end
  end

  def update
    if @unit.update(unit_params)
      if current_user.manager?
        redirect_to admin_unit_url(@unit)
      else
        redirect_to admin_units_url
      end
    else
      render action: 'edit'
    end
  end

  def destroy
    @unit.destroy
    redirect_to admin_units_url
  end

  private
    def set_unit
      @unit = Unit.friendly.find(params[:id])
    end

    def set_unit_courses
      @unit = Unit.friendly.find(params[:id])
      @courses = @unit.courses
    end

    def unit_params
      params.require(:unit).permit(:name, :logo, :slug, :color_theme, :about)
    end
end
