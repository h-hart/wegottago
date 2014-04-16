class CreateFriendPreferences < ActiveRecord::Migration
  def change
    create_table :friend_preferences do |t|
      t.string :sex
      t.string :relationship_status
      t.string :kids
      t.string :orientation
      t.integer :age_from
      t.integer :age_to

      t.timestamps
    end
  end
end
