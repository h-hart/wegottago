class HomeController < ApplicationController
  before_filter :redirect_to_root_if_authenticated, except: 'email_capture'
  layout 'unauthenticated'

  def index
  end

  def email_capture
    @reservation_email = session[:reservation_email]
    render 'home/email_capture', layout: 'pre_launch'
  end

  private
    def redirect_to_root_if_authenticated
      redirect_to root_path if user_signed_in?
    end
end
