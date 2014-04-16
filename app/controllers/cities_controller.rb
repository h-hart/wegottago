class CitiesController < ApplicationController
  layout "application"

  def show
    @city = if params[:name]
      City.find_by_name(params[:name])
    else
      City.find(params[:id])
    end
    get_activities

    render 'unauth_show' unless user_signed_in?
  end

  private
    def get_activities
      search = { "lat_gt"    => (@city.loc_lat - 1), 
                 "lng_gt"    => (@city.loc_lng - 1), 
                 "lat_lt"    => (@city.loc_lat + 1), 
                 "lng_lt"    => (@city.loc_lng + 2) }
      users_search = Hash[search.map { |k, v| ["loc_#{k}", v] }]

      if user_signed_in?
        @search = Activity.filter(current_user)
                          .order('activities.end_datetime ASC')
                          .search(search)
        @activities = @search.paginate(:page => params[:page], :per_page => 9)
        @users_going_places = User.joins(:activity_join).joins(:activities).includes(:activities).filter(current_user).includes(:themes).limit(4).search(users_search).all
      else
        @search = Activity
        .includes(:theme)
        .where('activities.end_datetime >= ?', Time.now)
        .search(search)
        @activities = @search.paginate(:page => params[:page], :per_page => 9)
        @users_going_places = User.joins(:curiosities).includes(:activities).includes(:themes).limit(4).search(users_search).all
      end
    end
end
