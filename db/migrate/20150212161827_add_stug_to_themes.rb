class AddStugToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :slug, :string
  end
end
