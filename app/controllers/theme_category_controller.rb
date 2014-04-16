class ThemeCategoryController < ApplicationController
  before_filter :authenticate_user!

  def index
    @ThemeCategory = ThemeCategory.select("DISTINCT theme_categories.id, theme_categories.name")
                      .joins('LEFT JOIN themes ON theme_categories.id = themes.theme_category_id')
                      .where("themes.id IS NOT NULL AND "+
                             "(themes.theme_category_id != #{ENV['THEME_OWN_CAT']} "+
                             "OR themes.user_id=#{current_user.id})")
                      .order("theme_categories.id ASC")
    render :json => @ThemeCategory
  end
end