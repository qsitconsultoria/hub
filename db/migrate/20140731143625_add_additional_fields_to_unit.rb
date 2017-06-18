class AddAdditionalFieldsToUnit < ActiveRecord::Migration
  def change
    add_column :units, :slug, :string
    add_column :units, :color_theme, :string
    add_column :units, :about, :text
  end
end
