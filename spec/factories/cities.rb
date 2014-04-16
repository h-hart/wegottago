# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do
    name "MyString"
    image "MyString"
    loc_lat 1
    loc_lng 1
  end
end
