require 'spec_helper'

describe SubjectsController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: 'unidade/superquadra/curso/rails/modulos/intro').to route_to('subjects#show', id: 'intro', unit_id: 'superquadra', course_id: 'rails')
    end

  end
end
