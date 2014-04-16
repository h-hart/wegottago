class InterestsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @activity_categories = ActivityCategory.tagged_with(@user.interests, :any => true)
  end
end