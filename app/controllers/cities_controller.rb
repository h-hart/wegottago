class CitiesController < ApplicationController
  layout "application"

  def show
    if ENV['PRELAUNCH_EMAIL_CAPTURE'] == 'show'
      return redirect_to '/splash'
    end
  
    @city = if params[:name]
      City.find_by_name(params[:name])
    else
      City.find(params[:id])
    end
    
    get_activities

    if user_signed_in?
      render 'show'
    else
      render 'unauth_show'
    end
  end

  private
    def get_activities
      search = {
        "lat_gt" => (@city.loc_lat - 1),
        "lng_gt" => (@city.loc_lng - 1),
        "lat_lt" => (@city.loc_lat + 1),
        "lng_lt" => (@city.loc_lng + 2)
      }
      users_search = Hash[search.map { |k, v|
        ["loc_#{k}", v]
      }]

      time_window_end = Time.now
      time_window_end -= 10.years if params[:show_past] == 'true'

      if user_signed_in?
        @search = Activity
          .filter(current_user)
          .order('activities.end_datetime ASC')
          .search(search)
        @users_going_places = User
          .joins(:activity_join)
          .joins(:activities)
          .includes(:activities)
          .filter(current_user)
          .includes(:themes)
          .limit(4)
          .search(users_search)
          .all
      else
        @search = Activity
          .includes(:theme)
          .where('activities.end_datetime >= ?', time_window_end)
          .search(search)
        @users_going_places = User
          .joins(:curiosities)
          .includes(:activities)
          .includes(:themes)
          .limit(4)
          .search(users_search)
          .all
      end
      @activities = @search.paginate(
        page: params[:page],
        per_page: 9
      )
    end
end
