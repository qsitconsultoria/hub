require "spec_helper"

describe Admin::LinksController do
  describe "routing" do

    it 'routes to #index' do
      expect(get: '/admin/unidades/superquadra/cursos/rails/referencias').to route_to('admin/links#index', unit_id: 'superquadra', course_id: 'rails')
    end

    it 'routes to #new' do
      expect(get: '/admin/unidades/superquadra/cursos/rails/referencias/new').to route_to('admin/links#new', unit_id: 'superquadra', course_id: 'rails')
    end

    it 'routes to #edit' do
      expect(get: '/admin/unidades/superquadra/cursos/rails/referencias/1/edit').to route_to('admin/links#edit', id: '1', unit_id: 'superquadra', course_id: 'rails')
    end

    it 'routes to #create' do
      expect(post: '/admin/unidades/superquadra/cursos/rails/referencias').to route_to('admin/links#create', unit_id: 'superquadra', course_id: 'rails')
    end

    it 'routes to #update' do
      expect(put: '/admin/unidades/superquadra/cursos/rails/referencias/1').to route_to('admin/links#update', id: '1', unit_id: 'superquadra', course_id: 'rails')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/unidades/superquadra/cursos/rails/referencias/1').to route_to('admin/links#destroy', id: '1', unit_id: 'superquadra', course_id: 'rails')
    end

  end
end
