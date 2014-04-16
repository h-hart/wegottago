class ChangeAboutInUsers < ActiveRecord::Migration
  def change
    change_column :users, :about, :text
  end
end
