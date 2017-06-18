require 'spec_helper'

describe Admin::SubjectsController do
  before { sign_in_teacher }

  let(:valid_attributes) { build(:subject).attributes }
  let(:unit) { create :unit }
  let(:course) { create :course, unit: unit }

  describe "GET index" do
    let(:subject) { create :subject, course: course }

    it "assigns all course subjects as @subjects" do
      get :index, unit_id: unit.to_param, course_id: course.to_param
      expect(assigns(:subjects)).to eq([subject])
    end
  end

  describe "GET show" do
    let(:subject) { create :subject, course: course }

    it "assigns the requested subject as @subject" do
      get :show, unit_id: unit.to_param, course_id: course.to_param, id: subject.to_param
      expect(assigns(:subject)).to eq(subject)
    end
  end

  describe "GET new" do
    it "assigns a new subject as @subject" do
      get :new, unit_id: unit.to_param, course_id: course.to_param
      expect(assigns(:subject)).to be_a_new(Subject)
    end
  end

  describe "GET edit" do
    let(:subject) { create :subject, course: course }

    it "assigns the requested subject as @subject" do
      get :edit, unit_id: unit.to_param, course_id: course.to_param, id: subject.to_param
      expect(assigns(:subject)).to eq(subject)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Subject" do
        expect {
          post :create, unit_id: unit.to_param, course_id: course.to_param, subject: valid_attributes
        }.to change(Subject, :count).by(1)
      end

      it "assigns a newly created subject as @subject" do
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject: valid_attributes
        expect(assigns(:subject)).to be_a(Subject)
        expect(assigns(:subject)).to be_persisted
      end

      it "redirects to the created subject" do
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject: valid_attributes
        expect(response).to redirect_to(admin_unit_course_subject_topics_url(unit, course, Subject.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved subject as @subject" do
        allow_any_instance_of(Subject).to receive(:save).and_return(false)
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject: { "name" => "invalid value" }
        expect(assigns(:subject)).to be_a_new(Subject)
      end

      it "re-renders the 'new' template" do
        allow_any_instance_of(Subject).to receive(:save).and_return(false)
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject: { "name" => "invalid value" }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    let!(:subject) { create :subject, course: course }

    describe "with valid params" do
      it "updates the requested subject" do
        expect_any_instance_of(Subject).to receive(:update).with({ "name" => "Intro" })
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: subject.to_param, subject: { "name" => "Intro" }
      end

      it "assigns the requested subject as @subject" do
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: subject.to_param, subject: valid_attributes
        expect(assigns(:subject)).to eq(subject)
      end

      it "redirects to the subject" do
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: subject.to_param, subject: valid_attributes
        expect(response).to redirect_to(admin_unit_course_subject_topics_url(unit, course, Subject.last))
      end
    end

    describe "with invalid params" do
      it "assigns the subject as @subject" do
        allow_any_instance_of(Subject).to receive(:save).and_return(false)
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: subject.to_param, :subject => { "name" => "invalid value" }
        expect(assigns(:subject)).to eq(subject)
      end

      it "re-renders the 'edit' template" do
        allow_any_instance_of(Subject).to receive(:save).and_return(false)
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: subject.to_param, :subject => { "name" => "invalid value" }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    let!(:subject) { create :subject, course: course }

    it "destroys the requested subject" do
      expect {
        delete :destroy, unit_id: unit.to_param, course_id: course.to_param, id: subject.to_param
      }.to change(Subject, :count).by(-1)
    end

    it "redirects to the subjects list" do
      delete :destroy, unit_id: unit.to_param, course_id: course.to_param, id: subject.to_param
      expect(response).to redirect_to(admin_unit_course_subjects_url(unit, course))
    end
  end

end
