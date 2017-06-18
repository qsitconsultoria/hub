require 'spec_helper'

describe Admin::QuestionsController do

  before { sign_in_teacher }

  let(:valid_attributes) { build(:question).attributes }
  let(:unit) { create :unit }
  let(:course) { create :course, unit: unit }
  let(:subject) { create :subject, course: course }

  describe "GET new" do
    it "assigns a new question as @question" do
      get :new, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param
      expect(assigns(:question)).to be_a_new(Question)
    end
  end

  describe "GET edit" do
    let(:question) { create :question, subject: subject }

    it "assigns the requested question as @question" do
      get :edit, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: question.to_param
      expect(assigns(:question)).to eq(question)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Question" do
        expect {
          post :create, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, question: valid_attributes
        }.to change(Question, :count).by(1)
      end

      it "assigns a newly created question as @question" do
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, question: valid_attributes
        expect(assigns(:question)).to be_a(Question)
        expect(assigns(:question)).to be_persisted
      end

      it "redirects to the created question" do
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, question: valid_attributes
        expect(response).to redirect_to(admin_unit_course_subject_topics_path(unit, course, subject))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved question as @question" do
        allow_any_instance_of(Question).to receive(:save).and_return(false)
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, question: { "title" => "invalid value" }
        expect(assigns(:question)).to be_a_new(Question)
      end

      it "re-renders the 'new' template" do
        allow_any_instance_of(Question).to receive(:save).and_return(false)
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, question: { "title" => "invalid value" }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:question) { create :question, subject: subject }

      it "updates the requested question" do
        expect_any_instance_of(Question).to receive(:update).with({ "title" => "MyString" })
        put :update, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: question.to_param, question: { "title" => "MyString" }
      end

      it "assigns the requested question as @question" do
        put :update, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: question.to_param, question: valid_attributes
        expect(assigns(:question)).to eq(question)
      end

      it "redirects to the question" do
        put :update, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: question.to_param, question: valid_attributes
        expect(response).to redirect_to(admin_unit_course_subject_topics_path(unit, course, subject))
      end
    end

    describe "with invalid params" do
      let(:question) { create :question, subject: subject }

      it "assigns the question as @question" do
        allow_any_instance_of(Question).to receive(:save).and_return(false)
        put :update, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: question.to_param, question: { "title" => "invalid value" }
        expect(assigns(:question)).to eq(question)
      end

      it "re-renders the 'edit' template" do
        allow_any_instance_of(Question).to receive(:save).and_return(false)
        put :update, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: question.to_param, question: { "title" => "invalid value" }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    let!(:question) { create :question, subject: subject }

    it "destroys the requested question" do
      expect {
        delete :destroy, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: question.to_param
      }.to change(Question, :count).by(-1)
    end

    it "redirects to the questions list" do
      delete :destroy, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: question.to_param
      expect(response).to redirect_to(admin_unit_course_subject_topics_path(unit, course, subject))
    end
  end

end
