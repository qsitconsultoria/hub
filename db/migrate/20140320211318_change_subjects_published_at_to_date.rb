class ChangeSubjectsPublishedAtToDate < ActiveRecord::Migration
  def up
    change_column :subjects, :published_at, :date
  end

  def down
    change_column :subjects, :published_at, :datetime
  end
end
