class Admin::ForumThreadsController < Admin::AdminController
  before_action :set_forum
  before_action :set_thread, only: [:edit, :update, :destroy]

  def new
    @thread = @forum.threads.build
  end

  def edit
  end

  def create
    @thread = @forum.threads.build(thread_params)

    if @thread.save
      redirect_to admin_unit_course_forum_url(@unit, @course, @forum)
    else
      render action: 'new'
    end
  end

  def update
    if @thread.update(thread_params)
      redirect_to admin_unit_course_forum_url(@unit, @course, @forum)
    else
      render action: 'edit'
    end
  end

  def destroy
    @thread.destroy
    redirect_to admin_unit_course_forum_url(@unit, @course, @forum)
  end

  private
    def set_thread
      @thread = ForumThread.find(params[:id])
    end

    def thread_params
      params.require(:forum_thread).permit(:title, :content, :user_id)
    end

    def set_forum
      @forum = Forum.find(params[:forum_id])
    end
end
