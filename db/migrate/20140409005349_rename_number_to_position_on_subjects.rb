class RenameNumberToPositionOnSubjects < ActiveRecord::Migration
  def change
    rename_column :subjects, :number, :position
  end
end
