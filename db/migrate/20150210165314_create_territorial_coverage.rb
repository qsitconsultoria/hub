class CreateTerritorialCoverage < ActiveRecord::Migration
  def change
    create_table :territorial_coverages do |t|
      t.string :name
      t.string :slug
    end
  end
end
