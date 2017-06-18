class CreateBiomes < ActiveRecord::Migration
  def change
    create_table :biomes do |t|
      t.string :name
    end
  end
end
