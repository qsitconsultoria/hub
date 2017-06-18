class AddSlugToBiomes < ActiveRecord::Migration
  def change
    add_column :biomes, :slug, :string
  end
end
