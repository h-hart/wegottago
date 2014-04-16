class AddIsReadFieldToUserActivities < ActiveRecord::Migration
  def change
    add_column :user_activities, :is_read, :boolean, default: false
  end
end
