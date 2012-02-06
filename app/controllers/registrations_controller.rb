class RegistrationsController < Devise::RegistrationsController
  
  def create
    build_resource
    code = Code.find_by_invite_code(resource.invite_code)
    if code == nil
      flash[:notice] = "Please use a valid invite code."
      redirect_to new_user_registration_path
      return
    end
        if resource.save
          if resource.active_for_authentication?
            set_flash_message :notice, :signed_up if is_navigational_format?
            sign_in(resource_name, resource)
            respond_with resource, :location => after_sign_up_path_for(resource)
          else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
            expire_session_data_after_sign_in!
            respond_with resource, :location => after_inactive_sign_up_path_for(resource)
          end
        else
          clean_up_passwords resource
          respond_with resource
        end
  end
  
end
