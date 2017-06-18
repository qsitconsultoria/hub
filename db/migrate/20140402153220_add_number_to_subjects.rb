class AddNumberToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :number, :string
    add_index :subjects, :number
  end
end
