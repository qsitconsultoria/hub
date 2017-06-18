class SubjectsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_subject, only: [:show]

  def show
    @topics = @subject.topics.ordered
    @links = @subject.links
    @teachers = @course.teachers

    authorize! :read, @subject
  end

  private
    def set_subject
      @subject = @course.subjects.friendly.find(params[:id])
    end
end
