class CreateThemeCategories < ActiveRecord::Migration
  def change
    create_table :theme_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
