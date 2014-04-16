module ViewsHelper

  def join_activity_for activity
    PublicActivity::Activity.create( key:      'Is going to your event', 
                                     trackable: activity, 
                                     recipient: activity.user, 
                                     owner:     current_user )

  end

  def view instance
    return unless user_signed_in?

    key = get_key_for instance
    if signed_in?
      PublicActivity::Activity.create( key: "Viewed #{key}", 
                                       trackable: instance, 
                                       recipient: instance, 
                                       owner: current_user )
    end
  end

  private
    def get_key_for instance
      case instance.class.name 
        when 'User'
          key = 'your Profile'
        else
          key = instance.class.name
      end

      key
    end
end