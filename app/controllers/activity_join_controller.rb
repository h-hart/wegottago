class ActivityJoinController < ApplicationController
  include ViewsHelper
  before_filter :authenticate_user!

  def join
    @activity = Activity.find(params[:id])

    if @activity.if_user_joined current_user.id
      @activity.user_unjoin current_user.id
      render text:'ok'
    else
      @activity_join = ActivityJoin.new(params[:activity])
      @activity_join.activity_id = params[:id]
      @activity_join.user_id = current_user.id
      join_activity_for @activity
      if @activity_join.save
        render text:'ok'
      else
        render text:'err'
      end
    end
  end
end