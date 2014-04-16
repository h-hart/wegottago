class AddSexToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sex, :string

    add_index :users, :sex
  end
end
