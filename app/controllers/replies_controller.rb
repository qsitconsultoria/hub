class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_thread, only: [:create, :destroy]
  before_action :set_reply, only: [:destroy]

  def create
    @reply = Reply.new(reply_params)

    if @reply.save
      redirect_to unit_course_forum_thread_url(@unit, @course, @thread)
    end
  end

  def destroy
    @reply.destroy
    redirect_to unit_course_forum_thread_url(@unit, @course, @thread)
  end

  private
    def set_reply
      @reply = Reply.find(params[:id])
    end

    def reply_params
      params.require(:reply).permit(:content, :forum_post_id, :user_id)
    end

    def set_thread
      @thread = ForumThread.find(params[:forum_thread_id])
    end
end
