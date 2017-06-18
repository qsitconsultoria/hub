require 'spec_helper'

describe Admin::CoursesController do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/admin/unidades/superquadra/cursos').to route_to('admin/courses#index', unit_id: 'superquadra')
    end

    it 'routes to #new' do
      expect(:get => '/admin/unidades/superquadra/cursos/new').to route_to('admin/courses#new', unit_id: 'superquadra')
    end

    it 'routes to #edit' do
      expect(:get => '/admin/unidades/superquadra/cursos/1/edit').to route_to('admin/courses#edit', unit_id: 'superquadra', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/admin/unidades/superquadra/cursos').to route_to('admin/courses#create', unit_id: 'superquadra')
    end

    it 'routes to #update' do
      expect(:put => '/admin/unidades/superquadra/cursos/1').to route_to('admin/courses#update', unit_id: 'superquadra', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/admin/unidades/superquadra/cursos/1').to route_to('admin/courses#destroy', unit_id: 'superquadra', :id => '1')
    end

  end
end
