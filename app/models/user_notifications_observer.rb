class UserNotificationsObserver < ActiveRecord::Observer
  observe :friendship, :activity

  def after_create(record)

    case record.class.to_s
    when "Friendship"
      if record.friend.allow_friend_request_notification?
        UserNotificationMailer.friend_request(record).deliver
      end
    when "Activity"
      users = User.joins(:user_notification).where('user_notifications.social_organised' => true).tagged_with( record.interest_tag_list, :any => true)
      emails = users.map{|u| u.email}
      UserNotificationMailer.new_social_organised(record, emails).deliver
    end
  end

end