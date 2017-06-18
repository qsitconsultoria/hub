class Admin::TopicsController < Admin::AdminController
  before_action :set_subject
  before_action :set_topic, only: [:edit, :update, :destroy]

  def index
    @topics = @subject.topics.ordered
    authorize! :see_topics, @subject
  end

  def new
    @topic = @subject.topics.new
    render 'edit'
    authorize! :create_new_topic, @topic
  end

  def edit
    authorize! :edit_topic, @topic
  end

  def create
    @topic = @subject.topics.new(topic_params)
    @topic.subject = @subject

    if @topic.save
      redirect_to edit_admin_unit_course_subject_topic_url(@unit, @course, @subject, @topic)
    else
      render action: 'edit'
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to edit_admin_unit_course_subject_topic_url(@unit, @course, @subject, @topic)
    else
      render action: 'edit'
    end
  end

  def destroy
    @topic.destroy
    redirect_to admin_unit_course_subject_topics_url(@unit, @course, @subject)
  end

  private
    def set_subject
      @subject = @course.subjects.friendly.find(params[:subject_id])
    end

    def set_topic
      @topic = @subject.topics.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:name, :content, images: [])
    end
end
