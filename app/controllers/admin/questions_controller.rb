class Admin::QuestionsController < Admin::AdminController
  before_action :set_subject
  before_action :set_question, only: [:edit, :update, :destroy]

  def new
    @question = Question.new
    authorize! :create_new_question, @question
  end

  def edit
    authorize! :edit_question, @question
  end

  def create
    @question = @subject.build_question(question_params)

    if @question.save
      redirect_to admin_unit_course_subject_topics_path(@unit, @course, @subject)
    else
      render action: 'new'
    end
  end

  def update
    if @question.update(question_params)
      redirect_to admin_unit_course_subject_topics_path(@unit, @course, @subject)
    else
      render action: 'edit'
    end
  end

  def destroy
    @question.destroy
    redirect_to admin_unit_course_subject_topics_path(@unit, @course, @subject)
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title)
    end

    def set_subject
      @subject = Subject.friendly.find(params[:subject_id])
    end
end
