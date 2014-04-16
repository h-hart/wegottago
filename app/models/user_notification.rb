class UserNotification < ActiveRecord::Base
  attr_accessible :friend_requests, :messages, :user_id, :social_organised
  belongs_to :user
end
