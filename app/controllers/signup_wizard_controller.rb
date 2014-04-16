class SignupWizardController < ApplicationController
  include Wicked::Wizard
  layout 'unauthenticated'

  steps :age_and_country,
        :user_info,
        :choose_interests,
        :confirm_profile

  def update
    @user = User.find(session[:user_id])
    @user.attributes = params[:user]
    render_wizard @user
  end

  def show
    @user = User.find(session[:user_id])
    case step
    when :confirm_profile
      skip_step if user_signed_in?
    when :choose_interests
      @activity_categories = ActivityCategory.order('activity_categories.name ASC').all
    end
    render_wizard
  end

end
