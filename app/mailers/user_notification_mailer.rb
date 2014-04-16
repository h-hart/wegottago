class UserNotificationMailer < ActionMailer::Base
  default from: "support@wegottago.com"

  def friend_request(friendship_record)
    @friendship_record = friendship_record
    mail( to: friendship_record.friend.email, 
          subject: "Friend request")
  end

  def new_social_organised(activity_record, emails)
    @activity_record = activity_record
    mail( to: emails, 
          subject: "New social organised that match your interests.")
  end

end
