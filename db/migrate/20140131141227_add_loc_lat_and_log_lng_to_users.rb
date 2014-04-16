class AddLocLatAndLogLngToUsers < ActiveRecord::Migration
  def change
    add_column :users, :loc_lat, :string
    add_column :users, :loc_lng, :string
  end
end
