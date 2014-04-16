class Page < ActiveRecord::Base
  attr_accessible :name, :text
  validates :name, uniqueness: true, length: { maximum: 256 }
end
