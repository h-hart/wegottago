class CuriosityController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    @activities = current_user.get_all_curious_activities
  end

  def curious
    @activity = Activity.find(params[:id])

    if @activity.if_user_curious current_user.id
      @activity.user_incurious current_user.id
      render text:'ok'
    else
      @curiosity = Curiosity.new(params[:curiosity])
      @curiosity.activity_id = params[:id]
      @curiosity.user_id = current_user.id

      if @curiosity.save
        render text:'ok'
      else
        render text:'err'
      end
    end
  end
end