module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def active_for path 
    request.fullpath == path ? 'active' : ''
  end

  def signed_in_and_not_current? user_id
    return false unless user_signed_in?
    if current_user.id != user_id
      true
    else
      false
    end
  end

  def signed_in_and_is_current? user_id
    return false unless signed_in?
    if current_user.id == user_id
      true
    else
      false
    end
  end

  def friends? user_id
    for friend in (current_user.friends + current_user.inverse_friends)
      if friend.id == user_id
        return true
      end
    end
  end

  def can_be_friend_with? user
    if user_signed_in?
      unless current_user.friend_preference.blank?
        return false unless ((!current_user.friend_preference.gender_male && !current_user.friend_preference.gender_female) || (current_user.friend_preference.gender_male && user.sex == 'Male') || (current_user.friend_preference.gender_female && user.sex == 'Female'))

        return false unless((!current_user.friend_preference.status_single && !current_user.friend_preference.status_married && !current_user.friend_preference.status_in_relationship) || (current_user.friend_preference.status_single && user.relationship_status == 'Single') || (current_user.friend_preference.status_married && user.relationship_status == 'Married') || (current_user.friend_preference.status_in_relationship && user.relationship_status == 'In a relationship'))

        return false unless((!current_user.friend_preference.orientation_straight && !current_user.friend_preference.orientation_gay && !current_user.friend_preference.orientation_bisexual) || (current_user.friend_preference.orientation_straight && user.orientation == 'Straight') || (current_user.friend_preference.orientation_gay && user.orientation == 'Gay') || (current_user.friend_preference.orientation_bisexual && user.orientation == 'Bisexual'))

        return false unless((!current_user.friend_preference.kids && !current_user.friend_preference.no_kids && !current_user.friend_preference.expecting_kids) || (current_user.friend_preference.kids && user.have_kids == 'Have Kids') || (current_user.friend_preference.no_kids && user.have_kids == 'No kids') || (current_user.friend_preference.expecting_kids && user.have_kids == 'Expecting'))

        unless current_user.friend_preference.age_from.blank?
          return false if current_user.friend_preference.age_from > user.age.to_i
        end
        unless current_user.friend_preference.age_to.blank?
          return false if current_user.friend_preference.age_to < user.age.to_i
        end
      end
      return true
    else
      return true
    end
  end

  def link_class link = false
    if link == params[:controller]
      'active'
    else
      ''
    end
  end

  def get_duplicates arr1, arr2
    arr1.find_all{|e| arr2.include?(e) } 
  end
end

