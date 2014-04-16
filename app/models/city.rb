class City < ActiveRecord::Base
  attr_accessible :image, :loc_lat, :loc_lng, :name

  mount_uploader :image, CityPhotoUploader

  validates_uniqueness_of :name

  def get_city_name
    name.split(',').first
  end
end
