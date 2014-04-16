class HomePageSliderPhotos < ActiveRecord::Base
  attr_accessible :image, :caption
  validates :image, presence: true
  mount_uploader :image, WideCategoryImageUploader
end
