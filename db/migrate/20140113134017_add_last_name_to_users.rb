class AddLastNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_name,           :string
    add_column :users, :age,                 :integer
    add_column :users, :country,             :string
    add_column :users, :zipcode,             :integer
    add_column :users, :occupation,          :string
    add_column :users, :relationship_status, :string
    add_column :users, :looking_for,         :string
    add_column :users, :about,               :string

    add_index  :users, :relationship_status
    add_index  :users, :age
    add_index  :users, :country
    add_index  :users, :looking_for
  end
end
