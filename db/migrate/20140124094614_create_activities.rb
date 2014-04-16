# Migration responsible for creating a table with activities
class CreateActivities < ActiveRecord::Migration
  # Create table
  def self.up
    create_table :user_activities do |t|
      t.belongs_to :trackable, :polymorphic => true
      t.belongs_to :owner, :polymorphic => true
      t.string  :key
      t.text    :parameters
      t.belongs_to :recipient, :polymorphic => true

      t.timestamps
    end

    add_index :user_activities, [:trackable_id, :trackable_type]
    add_index :user_activities, [:owner_id, :owner_type]
    add_index :user_activities, [:recipient_id, :recipient_type]
  end
  # Drop table
  def self.down
    drop_table :user_activities
  end
end
