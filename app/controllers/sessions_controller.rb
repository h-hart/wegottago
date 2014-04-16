class SessionsController < Devise::SessionsController
  layout "unauthenticated"

  def create
    flash[:sign_in_err] = "Invalid email or password."
    self.resource = warden.authenticate!(auth_options)
    flash.delete(:sign_in_err)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, :location => after_sign_in_path_for(resource)
  end
end
