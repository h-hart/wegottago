class ActivityJoin < ActiveRecord::Base
  attr_accessible :activity_id, :user_id
  validates :activity_id, :user_id, presence: true
  
  belongs_to :user
  belongs_to :activity
end
