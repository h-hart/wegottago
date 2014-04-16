class ActivityCategory < ActiveRecord::Base
  acts_as_taggable_on :interests

  attr_accessible :name, :small_image, :wide_image, :interest_list
  
  mount_uploader :wide_image, WideCategoryImageUploader
  mount_uploader :small_image, SmallCategoryImageUploader

  has_and_belongs_to_many :activities

  validates :name, presence: true
end
