require "spec_helper"

describe Admin::QuestionsController do
  describe "routing" do

    it 'routes to #new' do
      expect(get: '/admin/unidades/superquadra/cursos/rails/modulos/intro/perguntas/new').to route_to('admin/questions#new', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

    it 'routes to #edit' do
      expect(get: '/admin/unidades/superquadra/cursos/rails/modulos/intro/perguntas/1/edit').to route_to('admin/questions#edit', id: '1', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

    it 'routes to #create' do
      expect(post: '/admin/unidades/superquadra/cursos/rails/modulos/intro/perguntas').to route_to('admin/questions#create', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

    it 'routes to #update' do
      expect(put: '/admin/unidades/superquadra/cursos/rails/modulos/intro/perguntas/1').to route_to('admin/questions#update', id: '1', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/unidades/superquadra/cursos/rails/modulos/intro/perguntas/1').to route_to('admin/questions#destroy', id: '1', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

  end
end
