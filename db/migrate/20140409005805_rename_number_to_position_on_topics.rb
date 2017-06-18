class RenameNumberToPositionOnTopics < ActiveRecord::Migration
  def change
    rename_column :topics, :number, :position
  end
end
