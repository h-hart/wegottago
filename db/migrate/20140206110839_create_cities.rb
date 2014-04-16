class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.string :image
      t.integer :loc_lat
      t.integer :loc_lng

      t.timestamps
    end
  end
end
