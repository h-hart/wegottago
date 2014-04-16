class ChangedApprovedFieldIn < ActiveRecord::Migration
  def change
    change_column :friendships, :approved, :boolean, default: false
  end
end
