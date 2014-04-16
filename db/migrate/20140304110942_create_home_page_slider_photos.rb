class CreateHomePageSliderPhotos < ActiveRecord::Migration
  def change
    create_table :home_page_slider_photos do |t|
      t.string :image
    end
  end
end
