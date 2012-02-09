class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def dashboard
    @user_plan = current_user.plan
    @plans = Plan.all
  end
  
end
