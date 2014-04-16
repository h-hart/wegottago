class ThemeController < ApplicationController
  before_filter :authenticate_user!

  def show
    if ENV['THEME_OWN_CAT'] != params[:id]
      @themes = Theme.select("id, image").where("theme_category_id = ?", params[:id]).order("id DESC")
    else
      @themes = Theme.select("id, image").where("theme_category_id = #{ENV['THEME_OWN_CAT']} AND user_id=#{current_user.id}").order("id DESC")
    end
    render :json => @themes
  end

  def create
    theme_category = ThemeCategory.find_or_initialize_by_id(ENV['THEME_OWN_CAT'])
    theme_category.update_attributes :name => "My own"

    @theme = Theme.new(params[:theme])
    @theme.user_id = current_user.id
    @theme.theme_category_id = ENV['THEME_OWN_CAT']

    if @theme.save
       render text: 'ok'
    else
       render text: 'err'
    end
  end
end
