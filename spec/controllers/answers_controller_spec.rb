require 'spec_helper'

describe AnswersController do
  before { sign_in_student }

  let(:valid_attributes) { build(:answer).attributes }

  let(:unit) { create :unit }
  let(:course) { create :course, unit: unit }
  let(:subject) { create :subject, course: course }

  describe "GET show" do
    it "assigns the requested answer as @answer" do
      answer = create :answer, answerable: current_student
      get :show, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: answer.to_param
      expect(assigns(:answer)).to eq(answer)
    end
  end

  describe "GET new" do
    it "assigns a new answer as @answer" do
      get :new, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param
      expect(assigns(:answer)).to be_a_new(Answer)
    end
  end

  describe "GET edit" do
    it "assigns the requested answer as @answer" do
      answer = create :answer, answerable: current_student
      get :edit, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: answer.to_param
      expect(assigns(:answer)).to eq(answer)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Answer" do
        expect {
          post :create, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, answer: valid_attributes
        }.to change(Answer, :count).by(1)
      end

      it "assigns a newly created answer as @answer" do
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, answer: valid_attributes
        expect(assigns(:answer)).to be_a(Answer)
        expect(assigns(:answer)).to be_persisted
      end

      it "redirects to the created answer" do
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, answer: valid_attributes
        expect(response).to redirect_to([unit, course, subject, Answer.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved answer as @answer" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Answer).to receive(:save).and_return(false)
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, answer: { "content" => "invalid value" }
        expect(assigns(:answer)).to be_a_new(Answer)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Answer).to receive(:save).and_return(false)
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, answer: { "content" => "invalid value" }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested answer" do
        answer = create :answer, answerable: current_student
        expect_any_instance_of(Answer).to receive(:update).with({ "content" => "correct answer" })
        post :update, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: answer, answer: { "content" => "correct answer" }
      end

      it "assigns the requested answer as @answer" do
        answer = create :answer, answerable: current_student
        post :update, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: answer, answer: valid_attributes
        expect(assigns(:answer)).to eq(answer)
      end

      it "redirects to the answer" do
        answer = create :answer, answerable: current_student
        post :update, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: answer, answer: valid_attributes
        expect(response).to redirect_to([unit, course, subject, Answer.last])
      end
    end

    describe "with invalid params" do
      it "assigns the answer as @answer" do
        answer = create :answer, answerable: current_student
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Answer).to receive(:save).and_return(false)
        post :update, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: answer.to_param, answer: { "content" => "invalid value" }
        expect(assigns(:answer)).to eq(answer)
      end

      it "re-renders the 'edit' template" do
        answer = create :answer, answerable: current_student
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Answer).to receive(:save).and_return(false)
        post :update, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: answer.to_param, answer: { "content" => "invalid value" }
        expect(response).to render_template("edit")
      end
    end
  end
end
