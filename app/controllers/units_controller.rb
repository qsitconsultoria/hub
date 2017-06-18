class UnitsController < ApplicationController
  def show
    @unit = Unit.friendly.find(params[:id])
    @courses = @unit.courses
  end

  def instituto_chico_mendes
    unit = Unit.find_by(name: 'Unidade Virtual ICMBIO/Teste')

    redirect_to unit_url(unit)
  end
end
