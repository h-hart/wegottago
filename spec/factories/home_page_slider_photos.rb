# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :home_page_slider_photo, :class => 'HomePageSliderPhotos' do
    image "MyString"
  end
end
