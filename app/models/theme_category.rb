class ThemeCategory < ActiveRecord::Base
  attr_accessible :name

  has_many :themes, :dependent => :destroy

  validates :name, presence: true
end
