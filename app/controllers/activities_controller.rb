class ActivitiesController < ApplicationController
  include ViewsHelper
  before_filter :authenticate_user!

  def index

    @user = if params[:user_id]
      User.find(params[:user_id])
    else
      current_user
    end

    if (@user.id == current_user.id) # Own profile
      activities = Activity.select("activities.*")
      .joins('LEFT JOIN activity_joins ON activities.id = activity_joins.activity_id')
      .where("activity_joins.user_id = ? AND activity_joins.id IS NOT NULL", @user.id)
      .where('activities.end_datetime >= ?', Time.now)
      .order('activities.end_datetime ASC')
    else # Profile of anther user
      activities = Activity
      .filter(current_user)
      .order('activities.end_datetime ASC')
    end

    @grouped_activities = activities.group_by do |r| 
      if r.end_datetime.beginning_of_day == Date.today.beginning_of_day
        'Today'
      elsif r.end_datetime.beginning_of_day == Date.tomorrow.beginning_of_day
       'Tomorrow'
      else
        r.end_datetime.strftime("%A, %b. %eth, %Y")
      end 
    end
  end

  def show
    @activity = Activity.find(params[:id])
    view @activity unless @activity.user == current_user
  end

  def explore
    @activity_category = ActivityCategory.find(params[:activity_category_id])

    @location_contains = ""

    unless params[:search].nil?
      @location_contains = params[:search][:location_contains]
      params[:search][:location_contains] = ""
    end

    @end_datetime = ''

    unless params[:search].nil?
      @end_datetime = params[:search][:end_datetime_lte]
      case params[:search][:end_datetime_lte]
      when '1'
         params[:search][:end_datetime_lte] = Time.now.utc.end_of_day
      when '2'
         params[:search][:end_datetime_lte] = Time.now.utc.end_of_day + 1.days
         params[:search][:end_datetime_gte] = Time.now.utc.end_of_day
      when '3'
         params[:search][:end_datetime_lte] = ""
      end
    end

    @search = Activity.joins(:activity_categories)
    .where('activity_categories.id = ?', params[:activity_category_id])
    .filter(current_user)
    .search(params[:search])

    activities = @search.all

    @grouped_activities = activities.group_by do |r| 
      if r.end_datetime.beginning_of_day == Date.today.beginning_of_day
        'Today'
      elsif r.end_datetime.beginning_of_day == Date.tomorrow.beginning_of_day
       'Tomorrow'
      else
        r.end_datetime.strftime("%A, %b. %eth, %Y")
      end 
    end

    @four_suggested_activities = Activity.joins(:activity_categories)
    .where('activity_categories.id = ?', params[:activity_category_id])
    .filter(current_user)
    .limit(4)
  end

  def end_time
    @time = 1

    unless params[:time].nil?
      if Date.strptime(params[:time], '%A, %b %d, %Y') == DateTime.now.to_date
        @time = Time.new.in_time_zone('America/Los_Angeles').strftime("%k").to_i
      end
    end

    render :layout => false
  end

  def create
    @activity = Activity.new(params[:activity])

    @activity.user_id = current_user.id

    if (params[:activity]["date"].length)
      merged_date_and_time = params[:activity]["date"]+", "+params[:activity]["time"]+", 00"
      begin
        @activity.end_datetime = DateTime.strptime(merged_date_and_time, '%A, %b %d, %Y, %k, %S')
      rescue
        @activity.end_datetime = Time.now + 100.years
      end
    end

    if @activity.save
      @activity_join = ActivityJoin.new
      @activity_join.activity_id = @activity.id
      @activity_join.user_id = current_user.id

      if @activity_join.save
        redirect_to @activity
      else
        render text:'create err [AJ]'
      end
    else
      render text: 'create err [A]'
    end
  end
end
