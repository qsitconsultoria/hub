require 'spec_helper'

describe Admin::CoursesController do
  before { sign_in_teacher }

  let(:valid_attributes) { build(:course).attributes }
  let(:unit) { create :unit }

  describe "GET show" do
    let(:course) { create :course, unit: unit }

    it "assigns the requested course as @course" do
      get :show, unit_id: unit.to_param, id: course.to_param
      expect(assigns(:course)).to eq(course)
    end
  end

  describe "GET new" do
    it "assigns a new course as @course" do
      get :new, unit_id: unit.to_param
      expect(assigns(:course)).to be_a_new(Course)
    end
  end

  describe "GET edit" do
    let!(:course) { create(:course, unit: unit) }

    it "assigns the requested course as @course" do
      get :edit, unit_id: unit.to_param, id: course.to_param
      expect(assigns(:course)).to eq(course)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Course" do
        expect {
          post :create, unit_id: unit.to_param, course: valid_attributes
        }.to change(Course, :count).by(1)
      end

      it "assigns a newly created course as @course" do
        post :create, unit_id: unit.to_param, course: valid_attributes
        expect(assigns(:course)).to be_a(Course)
        expect(assigns(:course)).to be_persisted
      end

      it "redirects to the created course" do
        post :create, unit_id: unit.to_param, course: valid_attributes
        expect(response).to redirect_to(admin_unit_course_subjects_url(unit, Course.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved course as @course" do
        allow_any_instance_of(Course).to receive(:save).and_return(false)
        post :create, unit_id: unit.to_param, course: { "name" => "invalid value" }
        expect(assigns(:course)).to be_a_new(Course)
      end

      it "re-renders the 'new' template" do
        allow_any_instance_of(Course).to receive(:save).and_return(false)
        post :create, unit_id: unit.to_param, course: { "name" => "invalid value" }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let!(:course) { create(:course, unit: unit) }

      it "updates the requested course" do
        expect_any_instance_of(Course).to receive(:update).with({ "name" => "Rails for Designers" })
        put :update, unit_id: unit.to_param, id: course.to_param, course: { "name" => "Rails for Designers" }
      end

      it "assigns the requested course as @course" do
        put :update, unit_id: unit.to_param, id: course.to_param, course: valid_attributes
        expect(assigns(:course)).to eq(course)
      end

      it "redirects to the course" do
        put :update, unit_id: unit.to_param, id: course.to_param, course: valid_attributes
        expect(response).to redirect_to(admin_unit_course_subjects_url(unit, course))
      end
    end

    describe "with invalid params" do
      let!(:course) { create(:course, unit: unit) }

      it "assigns the course as @course" do
        allow_any_instance_of(Course).to receive(:save).and_return(false)
        put :update, unit_id: unit.to_param, id: course.to_param, course: { "name" => "invalid value" }
        expect(assigns(:course)).to eq(course)
      end

      it "re-renders the 'edit' template" do
        allow_any_instance_of(Course).to receive(:save).and_return(false)
        put :update, unit_id: unit.to_param, id: course.to_param, course: { "name" => "invalid value" }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    let!(:course) { create(:course, unit: unit) }

    it "destroys the requested course" do
      expect {
        delete :destroy, unit_id: unit.to_param, id: course.to_param
      }.to change(Course, :count).by(-1)
    end

    it "redirects to the courses list" do
      delete :destroy, unit_id: unit.to_param, id: course.to_param
      expect(response).to redirect_to(admin_unit_url(unit))
    end
  end
end
