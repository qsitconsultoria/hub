class AnswersController < ApplicationController
  before_action :set_subject
  before_action :set_question
  before_action :set_answer, only: [:edit, :update]
  before_action :set_links, only: [:show, :new, :edit]

  def show
    @answer = current_user.answers.find(params[:id])
  end

  def new
    @answer = Answer.new
  end

  def edit
  end

  def create
    @answer = Answer.new answer_params.merge(answerable: current_user, question: @question)

    if @answer.save
      notify_teachers_by_email @course.teachers, :create
      redirect_to [@unit, @course, @subject, @answer]
    else
      render action: 'new'
    end
  end

  def update
    if @answer.update(answer_params)
      notify_teachers_by_email @course.teachers, :update
      redirect_to [@unit, @course, @subject, @answer]
    else
      render action: 'edit'
    end
  end

  private
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:content)
    end

    def set_subject
      @subject = Subject.friendly.find(params[:subject_id])
    end

    def set_question
      @question = @subject.question
    end

    def notify_teachers_by_email(users, context)
      users.each do |teacher|
        StudentMailer.answer(@answer, current_user, teacher, context).deliver
      end
    end

    def set_links
      @links = @subject.links
    end
end
