class Comment < ActiveRecord::Base
  attr_accessible :activity_id, :text, :user_id

  validates :activity_id, :text, :user_id, presence: true

  belongs_to :activity
  belongs_to :user
end
