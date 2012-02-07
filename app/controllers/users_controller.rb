class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def dashboard
    @plan = current_user.plan
  end
  
end
