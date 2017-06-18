class SortablesController < ApplicationController
  before_action :authenticate_user!

  def update
    params['positions'].each do |index, attributes|
      resource = attributes['resource_name'].constantize
      id       = attributes['id']
      position = attributes['position']

      resource.find(id).update(position: position)
    end

    render nothing: true
  end
end
