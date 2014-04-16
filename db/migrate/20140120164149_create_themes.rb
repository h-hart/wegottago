class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.integer :id_theme_category
      t.string :image

      t.timestamps
    end
  end
end
