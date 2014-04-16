class RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy, :upload_photo]
  prepend_before_filter :static_pages, only: [:new, :create]

  layout "unauthenticated"

  def edit
    # Precreated list of avaliable Interests for user
    @interests = ActivityCategory.tag_counts_on(:interests)
    resource.build_user_notification unless resource.user_notification
    resource.build_friend_preference unless resource.friend_preference
    render layout: "application"
  end

  def create
    build_resource(sign_up_params)
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        session[:user_id] = resource.id
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def update
    @user = User.find(current_user.id)
    successfully_updated = if @user.password_required? || params[:user][:password]
      @user.update_with_password(params[:user])
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      params[:user].delete(:current_password) if params[:user][:current_password]
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      # Sign in the user bypassing validation in case his password changed
      @user.reprocess_profile if params[:user][:crop_x] && !@user.avatar.default?

      sign_in @user, :bypass => true
      respond_to do |format|
        format.html do
          set_flash_message :notice, :updated
          redirect_to edit_user_profile_path(tab: params[:tab]) 
        end
        format.js { @user }
      end
    else
      render "edit", layout: "application"
    end
  end

  def remove_avatar
    @user = User.find(current_user.id)
    @user.remove_avatar!
    if @user.save
      redirect_to edit_user_profile_path(tab: params[:tab]) 
    else
      render "edit", layout: "application"
    end
  end

  private

    def after_inactive_sign_up_path_for(resource)
      # Sign-up wizard
      signup_wizard_index_path
    end

    def static_pages
      @terms_of_service = Page.find_by_name('Terms of Service')
      @privacy_policy   = Page.find_by_name('Privacy Policy')
    end

end