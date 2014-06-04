class AddTagLineToActivityCategories < ActiveRecord::Migration
  def change
    add_column :activity_categories, :tag_line, :string
  end
end
