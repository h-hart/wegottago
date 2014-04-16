class AddSmallImageToActivityCategories < ActiveRecord::Migration
  def change
    add_column    :activity_categories, :small_image, :string
    rename_column :activity_categories, :image, :wide_image
  end
end
