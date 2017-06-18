class ForumPostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_thread, only: [:create, :destroy]
  before_action :set_forum_post, only: [:destroy]

  def create
    @forum_post = ForumPost.new(forum_post_params)

    if @forum_post.save
      redirect_to unit_course_forum_thread_url(@unit, @course, @thread)
    end
  end

  def destroy
    @forum_post.destroy
    redirect_to unit_course_forum_thread_url(@unit, @course, @thread)
  end

  private
    def set_forum_post
      @forum_post = ForumPost.find(params[:id])
    end

    def forum_post_params
      params.require(:forum_post).permit(:content, :forum_thread_id, :user_id)
    end

    def set_thread
      @thread = ForumThread.find(params[:forum_thread_id])
    end
end
