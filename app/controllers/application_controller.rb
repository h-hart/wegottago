class ApplicationController < ActionController::Base
  before_filter :get_unread_messages_and_notification, except: 'email_capture'

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  private
    def get_unread_messages_and_notification
      if user_signed_in?
        u_m_c = current_user.mailbox.receipts.where(is_read: false, trashed: false).size
        @unread_messages_count = u_m_c == 0 ? nil : u_m_c
        @last_messages = current_user.mailbox.receipts.where(trashed: false).limit(5)

        u_n_c = PublicActivity::Activity.where(recipient_id: current_user.id, recipient_type: "User", is_read: false).size

        @unread_notifications_count = u_n_c == 0 ? nil : u_n_c
        @last_notifications = PublicActivity::Activity.where({recipient_id: current_user.id, recipient_type: "User"}).order('created_at DESC').limit(5)
      end
    end

end
