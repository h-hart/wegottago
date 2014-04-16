class DeleteAndAddFields < ActiveRecord::Migration
  def change
    remove_column :themes, :id_theme_category
    add_column :themes, :theme_category_id, :integer
    add_index :themes, :theme_category_id

    add_column :activities, :user_id, :integer
    add_index :activities, :user_id

    add_column :themes, :user_id, :integer
    add_index :themes, :user_id
  end
end
