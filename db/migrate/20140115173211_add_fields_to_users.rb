class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :have_kids,  :string
    add_column :users, :wants_kids, :string
    add_column :users, :ethnicity,  :string
    add_column :users, :body_type,  :string
    add_column :users, :height,     :string
    add_column :users, :faith,      :string
    add_column :users, :smoke,      :string
    add_column :users, :drink,      :string
  end
end
