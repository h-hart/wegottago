
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end

puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.confirm!
user.add_role :user

user = User.find_or_create_by_email :name => 'SUser', :email => 'qwer@qwer.qwer', :password => 'qwerqwer', :password_confirmation => 'qwerqwer'
puts 'user: ' << user.name
user.confirm!
user.add_role :user

user = User.find_or_create_by_email :name => 'TestTestovich', :email => 'test.testovich111@test.com', :password => 'qwerqwer', :password_confirmation => 'qwerqwer'
puts 'user: ' << user.name
user.confirm!
user.add_role :user

puts 'Creating default cities'
city = City.find_or_create_by_name(name: 'Los Angeles', loc_lat: 34.0522342, loc_lng: '-118.2436849')
city.name = 'Los Angeles, CA, United States'
city.save

puts 'Creating default pages'
Page.find_or_create_by_name(name: 'Terms of Service', text: '')
Page.find_or_create_by_name(name: 'Privacy Policy', text: '')

theme_category = ThemeCategory.find_or_create_by_name :name => "Adventures Outdoors"
puts 'theme category: ' << theme_category.name
theme_category = ThemeCategory.find_or_create_by_name :name => "Artsy Fartsy"
puts 'theme category: ' << theme_category.name

theme_category = ThemeCategory.find_or_initialize_by_id(ENV['THEME_OWN_CAT'])
theme_category.update_attributes :name => "My own"
puts 'theme category: ' << theme_category.name

User.all.each do |u|
  unless u.friend_preference
    u.friend_preference = FriendPreference.create(
        :gender_male => false, 
        :gender_female => false,
        :status_single => false,
        :status_married => false,
        :status_in_relationship => false,
        :orientation_straight => false,
        :orientation_gay => false,
        :orientation_bisexual => false,
        :kids => false,
        :no_kids => false,
        :expecting_kids => false
      )
    u.save
  end
end

# Activity.delete_all
# Curiosity.delete_all
PublicActivity::Activity.delete_all