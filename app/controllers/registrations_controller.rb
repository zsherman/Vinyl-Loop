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
          resource.subscribe
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
  
  def edit
    @subscription = current_user.subscription
    @user = current_user
    render :edit
  end
  
  def destroy
      resource.destroy
      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      set_flash_message :notice, :destroyed if is_navigational_format?
      respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end
  
end