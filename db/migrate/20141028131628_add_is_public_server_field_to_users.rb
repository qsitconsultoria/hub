class AddIsPublicServerFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_public_server, :boolean
  end
end
