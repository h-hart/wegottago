class ChangeLatAndLngColumnsInCities < ActiveRecord::Migration
  def change
    change_column :cities, :loc_lat, :float
    change_column :cities, :loc_lng, :float
  end
end
