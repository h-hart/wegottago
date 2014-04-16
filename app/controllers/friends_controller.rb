class FriendsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_user!
  before_filter :get_friends, only: [:index, :explore]

  def explore
  end

  def index
    @all_friends = @user.get_friends(:is_limit=>false)
                        .paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def requests
    self.parse_params
    @suggestions = User
      .search(@suggestion_search_params)
    @suggestions_friends = @suggestions.first(8)
    @search = User
      .filter(current_user)
      .search(params[:search])
    @discovered_friends = @search
      .paginate(:page => params[:page])

    @requested_friends = current_user.get_friend_request
      .paginate(:page => params[:page])

  end

  def parse_params
    @location_contains = ""

    unless params[:search].blank?
      @location_contains = params[:search][:location_contains]
      params[:search][:location_contains] = ""

      @searched_sex = params[:search]['sex_equals']
      if params[:search]['sex_equals'] == 'Both'
        params[:search]['sex_equals'] = ''
      end
      @suggestion_search_params = params[:search].clone;
      @suggestion_search_params['sex_equals'] = ''
    end
  end

  private
    def get_user!
      if params[:id] # if there is no user id in params, show current one
        @user = User.find(params[:id])
      elsif user_signed_in? and params[:search].blank?
        @user = current_user
      elsif user_signed_in? and !params[:search].blank?
        @user = current_user
        @from_search_or_not_authorithed_user = true
      else
        @from_search_or_not_authorithed_user = true
      end
    end

    def get_friends
      self.parse_params

      @search = User
        .filter(current_user)
        .where("users.id != ?", current_user.id)
        .where('users.confirmed_at is NOT NULL OR users.provider is NOT NULL')
        .search(params[:search])

      @suggestions = User
        .filter(current_user)
        .where("users.id != ?", current_user.id)
        .where('users.confirmed_at is NOT NULL OR users.provider is NOT NULL')
        .limit(8)
        .search(@suggestion_search_params)
      @suggestions_friends = @suggestions.all
      
      @discovered_friends = @search
        .paginate(:page => params[:page])
    end
end
