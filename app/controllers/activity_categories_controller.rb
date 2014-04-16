class ActivityCategoriesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @activity_categories = ActivityCategory
    .includes(:activities)
    .order('activity_categories.name ASC')
    .all
    @main = ActivityCategory.where(name: 'Explore the world').first
  end
end
