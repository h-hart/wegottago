class UsersTableChangeColumnsType < ActiveRecord::Migration
  def change
    remove_column :users, :loc_lat
    add_column :users, :loc_lat, :integer

    remove_column :users, :loc_lng
    add_column :users, :loc_lng, :integer
  end
end
