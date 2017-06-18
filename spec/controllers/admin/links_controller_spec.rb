require 'spec_helper'

describe Admin::LinksController do
  before { sign_in_teacher }

  let(:valid_attributes) { build(:link).attributes.merge(subject_ids: [subject.id]) }
  let(:unit) { create :unit }
  let(:course) { create :course, unit: unit }
  let(:subject) { create :subject, course: course }

  describe "GET index" do
    let(:link) { create :link, subjects: [subject] }

    it "assigns all links as @links" do
      get :index, unit_id: unit.to_param, course_id: course.to_param
      expect(assigns(:links)).to eq([link])
    end
  end

  describe "GET new" do
    it "assigns a new link as @link" do
      get :new, unit_id: unit.to_param, course_id: course.to_param
      expect(assigns(:link)).to be_a_new(Link)
    end
  end

  describe "GET edit" do
    let(:link) { create :link, subjects: [subject] }

    it "assigns the requested link as @link" do
      get :edit, unit_id: unit.to_param, course_id: course.to_param, id: link.to_param
      expect(assigns(:link)).to eq(link)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Link" do
        expect {
          post :create, unit_id: unit.to_param, course_id: course.to_param, link: valid_attributes
        }.to change(Link, :count).by(1)
      end

      it "assigns a newly created link as @link" do
        post :create, unit_id: unit.to_param, course_id: course.to_param, link: valid_attributes
        expect(assigns(:link)).to be_a(Link)
        expect(assigns(:link)).to be_persisted
      end

      it "redirects to the created link" do
        post :create, unit_id: unit.to_param, course_id: course.to_param, link: valid_attributes
        expect(response).to redirect_to(admin_unit_course_links_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved link as @link" do
        allow_any_instance_of(Link).to receive(:save).and_return(false)
        post :create, unit_id: unit.to_param, course_id: course.to_param, link: { 'name' => 'invalid value' }
        expect(assigns(:link)).to be_a_new(Link)
      end

      it "re-renders the 'new' template" do
        allow_any_instance_of(Link).to receive(:save).and_return(false)
        post :create, unit_id: unit.to_param, course_id: course.to_param, link: { 'name' => 'invalid value' }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    let(:link) { create :link, subjects: [subject] }

    describe "with valid params" do
      it "updates the requested link" do
        expect_any_instance_of(Link).to receive(:update).with( { 'name' => 'Document' })
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: link.to_param, link:  { 'name' => 'Document' }
      end

      it "assigns the requested link as @link" do
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: link.to_param, link: valid_attributes
        expect(assigns(:link)).to eq(link)
      end

      it "redirects to the link" do
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: link.to_param, link: valid_attributes
        expect(response).to redirect_to(admin_unit_course_links_url)
      end
    end

    describe "with invalid params" do
      it "assigns the link as @link" do
        allow_any_instance_of(Link).to receive(:save).and_return(false)
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: link.to_param, link:  { 'name' => 'invalid value' }
        expect(assigns(:link)).to eq(link)
      end

      it "re-renders the 'edit' template" do
        allow_any_instance_of(Link).to receive(:save).and_return(false)
        put :update, unit_id: unit.to_param, course_id: course.to_param, id: link.to_param, link:  { 'name' => 'invalid value' }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    let!(:link) { create :link, subjects: [subject] }

    it "destroys the requested link" do
      expect {
        delete :destroy, unit_id: unit.to_param, course_id: course.to_param, id: link.to_param
      }.to change(Link, :count).by(-1)
    end

    it "redirects to the links list" do
      delete :destroy, unit_id: unit.to_param, course_id: course.to_param, id: link.to_param
      expect(response).to redirect_to(admin_unit_course_links_url)
    end
  end

end
