class AddLatLngToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :lat, :float
    add_column :activities, :lng, :float
  end
end
