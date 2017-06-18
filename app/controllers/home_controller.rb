class HomeController < ApplicationController
  def index
    redirect_to unit_url(Unit.first)
  end
end
