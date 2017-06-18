require 'spec_helper'

describe Admin::TeachersController do
  let(:unit) { create :unit }
  let(:course) { create :course, unit: unit }

  before { sign_in_teacher }

  let(:valid_attributes) do
    attributes = build(:teacher).attributes
    attributes[:password] = '12345678'
    attributes[:password_confirmation] = '12345678'
    attributes
  end

  #FIXME
  describe "GET index" do
    it "assigns all teachers as @teachers" do
      get :index, unit_id: unit.to_param, course_id: course.to_param
      #expect(assigns(:teachers)).to eq([current_teacher])
    end
  end

  describe "GET new" do
    it "assigns a new teacher as @teacher" do
      get :new, unit_id: unit.to_param, course_id: course.to_param
      expect(assigns(:teacher)).to be_a_new(Teacher)
    end
  end

  describe "GET edit" do
    let!(:teacher) { create :teacher }

    it "assigns the requested teacher as @teacher" do
      get :edit, unit_id: unit.to_param, course_id: course.to_param, id: teacher.to_param
      expect(assigns(:teacher)).to eq(teacher)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Teacher" do
        expect {
          post :create, unit_id: unit.to_param, course_id: course.to_param, teacher: valid_attributes
        }.to change(Teacher, :count).by(1)
      end

      it "assigns a newly created teacher as @teacher" do
        post :create, unit_id: unit.to_param, course_id: course.to_param, teacher: valid_attributes
        expect(assigns(:teacher)).to be_a(Teacher)
        expect(assigns(:teacher)).to be_persisted
      end

      it "redirects to the teachers list" do
        post :create, unit_id: unit.to_param, course_id: course.to_param, teacher: valid_attributes
        expect(response).to redirect_to(admin_unit_course_teachers_url(unit, course))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved teacher as @teacher" do
        allow_any_instance_of(Teacher).to receive(:save).and_return(false)
        post :create, unit_id: unit.to_param, course_id: course.to_param, teacher: { "name" => "invalid value" }
        expect(assigns(:teacher)).to be_a_new(Teacher)
      end

      it "re-renders the 'new' template" do
        allow_any_instance_of(Teacher).to receive(:save).and_return(false)
        post :create, unit_id: unit.to_param, course_id: course.to_param, teacher: { "name" => "invalid value" }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params containing password" do
      let!(:teacher) { create :teacher }

      it "updates the requested teacher" do
        attributes_with_password = { "name" => "John Doe", "password" => "12345678", "password_confirmation" => "12345678" }
        expect_any_instance_of(Teacher).to receive(:update).with(attributes_with_password)
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: teacher.to_param, teacher: attributes_with_password
      end

      it "assigns the requested teacher as @teacher" do
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: teacher.to_param, teacher: valid_attributes
        expect(assigns(:teacher)).to eq(teacher)
      end

      it "redirects to the teachers list" do
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: teacher.to_param, teacher: valid_attributes
        expect(response).to redirect_to(admin_unit_course_teachers_url(unit, course))
      end
    end

    describe "with valid params without password" do
      let!(:teacher) { create :teacher }

      it "updates the requested teacher" do
        expect_any_instance_of(Teacher).to receive(:update_without_password).with({ "name" => "John Doe" })
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: teacher.to_param, teacher: { "name" => "John Doe" }
      end

      it "assigns the requested teacher as @teacher" do
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: teacher.to_param, teacher: valid_attributes
        expect(assigns(:teacher)).to eq(teacher)
      end

      it "redirects to the teachers list" do
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: teacher.to_param, teacher: valid_attributes
        expect(response).to redirect_to(admin_unit_course_teachers_url(unit, course))
      end
    end

    describe "with invalid params" do
      let!(:teacher) { create :teacher }

      it "assigns the teacher as @teacher" do
        allow_any_instance_of(Teacher).to receive(:save).and_return(false)
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: teacher.to_param, teacher: { "name" => "invalid value", "password" => "123" }
        expect(assigns(:teacher)).to eq(teacher)
      end

      it "re-renders the 'edit' template" do
        allow_any_instance_of(Teacher).to receive(:save).and_return(false)
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: teacher.to_param, teacher: { "name" => "invalid value", "password" => "123" }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    let!(:teacher) { create :teacher }

    it "destroys the requested teacher" do
      expect {
        delete :destroy, unit_id: unit.to_param, course_id: course.to_param, id: teacher.to_param
      }.to change(Teacher, :count).by(-1)
    end

    it "redirects to the teachers list" do
      delete :destroy, unit_id: unit.to_param, course_id: course.to_param, id: teacher.to_param
      expect(response).to redirect_to(admin_unit_course_teachers_url(unit, course))
    end
  end

end
