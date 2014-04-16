class AddSocialOrganisedToUserNotifications < ActiveRecord::Migration
  def change
    add_column :user_notifications, :social_organised, :boolean
    add_index  :user_notifications, :social_organised
  end
end
