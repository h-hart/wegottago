class RenameNotificationsTableToUserNotifications < ActiveRecord::Migration
  def change
    rename_table :notifications, :user_notifications
  end
end
