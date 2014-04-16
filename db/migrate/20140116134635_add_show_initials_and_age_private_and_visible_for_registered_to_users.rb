class AddShowInitialsAndAgePrivateAndVisibleForRegisteredToUsers < ActiveRecord::Migration
  def change
    add_column :users, :show_initials, :boolean,          default: true
    add_column :users, :age_private, :boolean,            default: false
    add_column :users, :visible_for_registered, :boolean, default: false

    add_index  :users, :visible_for_registered
  end
end
