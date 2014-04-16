class AddImageToActivityCategories < ActiveRecord::Migration
  def change
    add_column :activity_categories, :image, :string
  end
end
