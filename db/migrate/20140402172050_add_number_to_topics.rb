class AddNumberToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :number, :string
  end
end
