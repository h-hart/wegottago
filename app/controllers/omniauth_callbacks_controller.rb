class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  before_filter :authenticate_user!, :except => [:all]

  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    user.remote_avatar_url = "#{request.env["omniauth.auth"].info.image}&height=162"
    if user.persisted? && user.wizard_complited?
      sign_in_and_redirect user, notice: "Signed in!"
    else
      unless user.wizard_complited?
        sign_in(:user, user)
        session[:user_id] = user.id
        location = signup_wizard_index_path
      end
      session["devise.user_attributes"] = user.attributes
      redirect_to  location || new_user_registration_url
    end
  end

  alias_method :facebook,  :all
end