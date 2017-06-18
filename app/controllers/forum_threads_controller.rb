class ForumThreadsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_forum
  before_action :set_thread, only: [:show, :edit, :update, :destroy]

  def show
    @thread.update_column('views_count', @thread.views_count+1)
  end

  def new
    @thread = ForumThread.new
  end

  private
    def set_thread
      @thread = ForumThread.find(params[:id])
    end

    def set_forum
      @forum = @course.forum
    end
end
