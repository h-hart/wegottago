class AddNewFieldsToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :kids, :boolean
    add_column :activities, :no_kids, :boolean
    add_column :activities, :expecting_kids, :boolean
  end
end
