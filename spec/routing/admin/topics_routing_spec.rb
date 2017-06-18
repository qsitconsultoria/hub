require 'spec_helper'

describe Admin::TopicsController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/admin/unidades/superquadra/cursos/rails/modulos/intro/topicos').to route_to('admin/topics#index', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

    it 'routes to #new' do
      expect(get: '/admin/unidades/superquadra/cursos/rails/modulos/intro/topicos/new').to route_to('admin/topics#new', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

    it 'routes to #edit' do
      expect(get: '/admin/unidades/superquadra/cursos/rails/modulos/intro/topicos/1/edit').to route_to('admin/topics#edit', id: '1', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

    it 'routes to #create' do
      expect(post: '/admin/unidades/superquadra/cursos/rails/modulos/intro/topicos').to route_to('admin/topics#create', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

    it 'routes to #update' do
      expect(put: '/admin/unidades/superquadra/cursos/rails/modulos/intro/topicos/1').to route_to('admin/topics#update', id: '1', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/unidades/superquadra/cursos/rails/modulos/intro/topicos/1').to route_to('admin/topics#destroy', id: '1', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

  end
end
