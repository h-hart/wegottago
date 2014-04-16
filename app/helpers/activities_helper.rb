module ActivitiesHelper
  def timeArr from = false
    hours = 1..12
    time = Hash.new()

    hours.each do |hour|
      if from == false or from <= hour then
        time["#{hour}:00 AM"] = hour
      end
    end

    hours.each do |hour|
      hour24 = hour+12
      if from == false or from <= hour24 then
        hour24 = 0 if hour24 == 24

        time["#{hour}:00 PM"] = hour24
      end
    end

    time
  end

  def activitiesNum user_id = false
    if user_signed_in?
      user_id = @user.id if user_id == false
  
      Activity.select("activities.id")
      .joins('LEFT JOIN activity_joins ON activities.id = activity_joins.activity_id')
      .where("activity_joins.user_id = ? AND activity_joins.id IS NOT NULL", user_id)
      .count.to_s
    end
  end

  def lastFourActivities
    if user_signed_in?
      Activity.select("activities.*")
      .joins('LEFT JOIN activity_joins ON activities.id = activity_joins.activity_id')
      .where("activity_joins.user_id = ? AND activity_joins.id IS NOT NULL", @user.id)
      .order("activity_joins.id DESC")
      .limit(4)
    end
  end
end
