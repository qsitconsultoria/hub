require 'spec_helper'

describe HomeController do
  let!(:unit) { create :unit }

  describe "GET 'index'" do
    it "returns redirects to first unit" do
      get :index
      expect(response).to redirect_to(unit_url(Unit.first))
    end
  end

end
