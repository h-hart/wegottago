class AddCaptionToHomePageSliderPhotos < ActiveRecord::Migration
  def change
    add_column :home_page_slider_photos, :caption, :text
  end
end
