require 'spec_helper'

describe Admin::AdminController do
  controller(Admin::AdminController) do
    def index
      render nothing: true
    end
  end

  let!(:course) { create :course }

  before do
    routes.draw { get 'admin/admin/index' => 'admin/admin#index' }
    sign_in_teacher
  end

  it 'sets @courses with all courses' do
    get :index
    expect(assigns(:courses)).to eq([course])
  end

  # TODO: example for CanCan::AccessDenied
end