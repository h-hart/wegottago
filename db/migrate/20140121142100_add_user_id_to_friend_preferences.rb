class AddUserIdToFriendPreferences < ActiveRecord::Migration
  def change
    add_column :friend_preferences, :user_id, :integer
  end
end
