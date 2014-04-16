class AddOrientationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :orientation, :string
  end
end
