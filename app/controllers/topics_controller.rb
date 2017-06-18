class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subject
  before_action :set_topic
  before_action :set_prev_and_next

  def show
    @links = @subject.links
  end

  private
    def set_subject
      @subject = @course.subjects.friendly.find(params[:subject_id])
    end

    def set_topic
      @topic = @subject.topics.find(params[:id])
    end

    def set_prev_and_next
      # @prev_topic = @topic.find()
      # @next_topic =
      # @next_topic_link = course_subject_topic_path(current_course, @subject, @prev_topic)
      # @prev_topic_link = course_subject_topic_path(current_course, @subject, @next_topic)
    end
end
