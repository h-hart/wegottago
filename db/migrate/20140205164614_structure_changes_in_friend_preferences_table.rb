class StructureChangesInFriendPreferencesTable < ActiveRecord::Migration
  def change
    remove_column :friend_preferences, :sex
    remove_column :friend_preferences, :relationship_status
    remove_column :friend_preferences, :kids
    remove_column :friend_preferences, :orientation


    add_column :friend_preferences, :gender_male, :boolean
    add_column :friend_preferences, :gender_female, :boolean

    add_column :friend_preferences, :status_single, :boolean
    add_column :friend_preferences, :status_married, :boolean
    add_column :friend_preferences, :status_in_relationship, :boolean

    add_column :friend_preferences, :orientation_straight, :boolean
    add_column :friend_preferences, :orientation_gay, :boolean
    add_column :friend_preferences, :orientation_bisexual, :boolean

    add_column :friend_preferences, :kids, :boolean
    add_column :friend_preferences, :no_kids, :boolean
    add_column :friend_preferences, :expecting_kids, :boolean
  end
end
