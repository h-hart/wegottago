class UsersTableChangeColumnsType2 < ActiveRecord::Migration
  def change
    remove_column :users, :loc_lat
    add_column :users, :loc_lat, :float

    remove_column :users, :loc_lng
    add_column :users, :loc_lng, :float
  end
end
