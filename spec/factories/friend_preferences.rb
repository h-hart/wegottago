# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :friend_preference do
    sex "MyString"
    relationship_status "MyString"
    kids "MyString"
    orientation "MyString"
    age_from 1
    age_to 1
  end
end
