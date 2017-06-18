class LinksController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @links = @course.links
  end
end
