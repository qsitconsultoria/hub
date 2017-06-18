class AddIconToLinks < ActiveRecord::Migration
  def change
    add_column :links, :icon, :string, default: 'link'
  end
end
