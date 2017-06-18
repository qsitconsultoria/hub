require 'spec_helper'

describe Admin::UnitsController do
  before { sign_in_teacher }
  let(:unit) { create :unit }

  let(:valid_attributes) do
    attributes = build(:unit).attributes
    attributes[:name] = 'MMA'
    attributes[:slug] = 'mma'
    attributes[:color_theme] = Unit::COLORS.first
    attributes[:about] = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.'
    attributes
  end

  describe "GET index", pending: true do
    let(:course) { create :course, unit: unit }
    let!(:subject) { create :subject, course: course }

    it "assigns all units as @units" do
      get :index
      expect(assigns(:units)).to eq([unit])
    end
  end

  describe "GET new" do
    it "assigns a new unit as @unit" do
      get :new
      expect(assigns(:unit)).to be_a_new(Unit)
    end
  end

  describe "GET edit" do
    let!(:unit) { create :unit }

    it "assigns the requested unit as @unit" do
      get :edit, {id: unit.to_param}
      expect(assigns(:unit)).to eq(unit)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Unit" do
        expect {
          post :create, {unit: valid_attributes}
        }.to change(Unit, :count).by(1)
      end

      it "assigns a newly created unit as @unit" do
        post :create, {unit: valid_attributes}
        expect(assigns(:unit)).to be_a(Unit)
        expect(assigns(:unit)).to be_persisted
      end

      it "redirects to the units list" do
        post :create, {unit: valid_attributes}
        expect(response).to redirect_to(new_admin_unit_manager_url(Unit.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved unit as @unit" do
        allow_any_instance_of(Unit).to receive(:save).and_return(false)
        post :create, {unit: { "name" => "invalid value" }}
        expect(assigns(:unit)).to be_a_new(Unit)
      end

      it "re-renders the 'new' template" do
        allow_any_instance_of(Unit).to receive(:save).and_return(false)
        post :create, {unit: { "name" => "invalid value" }}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let!(:unit) { create :unit }

      it "updates the requested unit" do
        attributes = { "name" => "IBAMA" }
        expect_any_instance_of(Unit).to receive(:update).with(attributes)
        put :update, {id: unit.to_param, unit: attributes}
      end

      it "assigns the requested unit as @unit" do
        put :update, {id: unit.to_param, unit: valid_attributes}
        expect(assigns(:unit)).to eq(unit)
      end

      it "redirects to the units list" do
        put :update, {id: unit.to_param, unit: valid_attributes}
        expect(response).to redirect_to(admin_units_url)
      end
    end

    describe "with invalid params" do
      let!(:unit) { create :unit }

      it "assigns the unit as @unit" do
        allow_any_instance_of(Unit).to receive(:save).and_return(false)
        put :update, {id: unit.to_param, unit: { "name" => "invalid value"}}
        expect(assigns(:unit)).to eq(unit)
      end

      it "re-renders the 'edit' template" do
        allow_any_instance_of(Unit).to receive(:save).and_return(false)
        put :update, {id: unit.to_param, unit: { "name" => "invalid value"}}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    let!(:unit) { create :unit }

    it "destroys the requested unit" do
      expect {
        delete :destroy, {id: unit.to_param}
      }.to change(Unit, :count).by(-1)
    end

    it "redirects to the units list" do
      delete :destroy, {id: unit.to_param}
      expect(response).to redirect_to(admin_units_url)
    end
  end
end
