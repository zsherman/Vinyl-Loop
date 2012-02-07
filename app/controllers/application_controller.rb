class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource_or_scope)
      if !current_user.plan
        root_path
      elsif current_user.plan
        "/dashboard"
      end
  end
  
end
