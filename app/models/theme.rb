class Theme < ActiveRecord::Base
  attr_accessible :theme_category_id, :image, :user_id

  belongs_to :user
  belongs_to :theme_category
  has_many :activities, :dependent => :destroy

  mount_uploader :image, ThemeImageUploader

  validates :theme_category_id, :user_id, :image, presence: true
end
