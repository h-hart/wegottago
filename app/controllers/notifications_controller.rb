class NotificationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    conditions = {recipient_id: current_user.id, recipient_type: "User"}
    PublicActivity::Activity.update_all({is_read: true}, conditions)
    get_unread_messages_and_notification
    @notifications = PublicActivity::Activity.where(conditions).order('created_at DESC')
      .paginate(:page => params[:page], :per_page => 10)
  end
end
