class ChangeColumnLocationInUsers < ActiveRecord::Migration
  def change
    change_column :users, :location, :string, :null => false, :default => ''
  end
end
