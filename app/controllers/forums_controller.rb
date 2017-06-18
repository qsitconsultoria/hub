class ForumsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_forum, only: [:show]

  def show
    @threads = @forum.threads
  end

  private
    def set_forum
      @forum = @course.forum
    end
end
