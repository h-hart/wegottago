class FriendPreference < ActiveRecord::Base
  attr_accessible :age_from, :age_to, :gender_male, :gender_female, 
                  :status_single, :status_married, :status_in_relationship, 
                  :orientation_straight, :orientation_gay, :orientation_bisexual, 
                  :kids, :no_kids, :expecting_kids, :user_id
  belongs_to :user
end
