class HomeController < ApplicationController
  before_filter :redirect_to_root_if_authenticated
  layout 'unauthenticated'

  def index
  end

  def email_capture
    render 'home/email_capture', layout: 'pre_launch', locals: { message: 'Get Notified When We Launch!' }
  end

  private
    def redirect_to_root_if_authenticated
      redirect_to root_path if user_signed_in?
    end
end
