require "spec_helper"

describe AnswersController do
  describe "routing" do

    it 'routes to #show' do
      expect(get: 'unidade/superquadra/curso/rails/modulos/intro/respostas/1').to route_to('answers#show', id: '1', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

    it 'routes to #new' do
      expect(get: 'unidade/superquadra/curso/rails/modulos/intro/respostas/new').to route_to('answers#new', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

    it 'routes to #edit' do
      expect(get: 'unidade/superquadra/curso/rails/modulos/intro/respostas/1/edit').to route_to('answers#edit', id: '1', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

    it 'routes to #create' do
      expect(post: 'unidade/superquadra/curso/rails/modulos/intro/respostas').to route_to('answers#create', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

    it 'routes to #update' do
      expect(put: 'unidade/superquadra/curso/rails/modulos/intro/respostas/1').to route_to('answers#update', id: '1', unit_id: 'superquadra', course_id: 'rails', subject_id: 'intro')
    end

  end
end
