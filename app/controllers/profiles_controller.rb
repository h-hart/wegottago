class ProfilesController < ApplicationController
  include ViewsHelper
  before_filter :authenticate_user!, except: [:show]
  before_filter :get_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    # standalone activity. 
    # Method is defined in ProfilesHelper
    if !user_signed_in? && !@user.visible_for_registered
      redirect_to root_path, notice: 'This user profile is private for unauthorized users!'
    end
    view @user unless current_user == @user
  end

  private
    def get_user
      if params[:id].nil? # if there is no user id in params, show current one
        @user = current_user
      else
        @user = User.find(params[:id])
      end
    end
end
