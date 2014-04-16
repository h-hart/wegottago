# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    theme_id 1
    title "MyString"
    personal_quote "MyString"
    end_datetime "2014-01-17 14:19:41"
    location "MyString"
    details "MyText"
    people_number 1
    people_ask_others false
    gender_male false
    gender_female false
    status_single false
    status_married false
    status_in_relationship false
    orientation_straight false
    orientation_gay false
    orientation_bisexual false
    age_all false
    age_from 1
    age_to 1
  end
end
