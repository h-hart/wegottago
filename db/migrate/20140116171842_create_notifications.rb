class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :friend_requests, :default => false
      t.boolean :messages, :default => false
      t.integer :user_id
    end
  end
end
