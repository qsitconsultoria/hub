require 'spec_helper'

describe Admin::SubjectsController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/admin/unidades/superquadra/cursos/rails/modulos').to route_to('admin/subjects#index', unit_id: 'superquadra', course_id: 'rails')
    end

    it 'routes to #new' do
      expect(get: '/admin/unidades/superquadra/cursos/rails/modulos/new').to route_to('admin/subjects#new', unit_id: 'superquadra', course_id: 'rails')
    end

    it 'routes to #show' do
      expect(get: '/admin/unidades/superquadra/cursos/rails/modulos/intro').to route_to('admin/subjects#show', id: 'intro', unit_id: 'superquadra', course_id: 'rails')
    end

    it 'routes to #edit' do
      expect(get: '/admin/unidades/superquadra/cursos/rails/modulos/intro/edit').to route_to('admin/subjects#edit', id: 'intro', unit_id: 'superquadra', course_id: 'rails')
    end

    it 'routes to #create' do
      expect(post: '/admin/unidades/superquadra/cursos/rails/modulos').to route_to('admin/subjects#create', unit_id: 'superquadra', course_id: 'rails')
    end

    it 'routes to #update' do
      expect(put: '/admin/unidades/superquadra/cursos/rails/modulos/intro').to route_to('admin/subjects#update', id: 'intro', unit_id: 'superquadra', course_id: 'rails')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/unidades/superquadra/cursos/rails/modulos/intro').to route_to('admin/subjects#destroy', id: 'intro', unit_id: 'superquadra', course_id: 'rails')
    end

  end
end
