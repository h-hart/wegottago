module NavigationHelper

  def internal_page? (url)
    external = [
      '',
      '/',
      '/users/sign_in',
      '/users/sign_up',
      '/signup_wizard/user_info',
      '/signup_wizard/photo',
      '/signup_wizard/choose_interests',
      '/signup_wizard/confirm_profile'
    ].include? url
    !external
  end

end
