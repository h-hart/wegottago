class AddFieldToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :last_activity_datatime, :datetime
  end
end
