class CreateLinksSubjects < ActiveRecord::Migration
  def change
    create_table :links_subjects, id: false do |t|
      t.belongs_to :link, index: true
      t.belongs_to :subject, index: true
    end
  end
end
