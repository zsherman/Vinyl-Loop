class UsersController < ApplicationController
  before_filter :check_signed_in
  before_filter :check_plan
  
  def show
    @user = User.find(params[:id])
  end
  
  def dashboard
    @title = "dashboard"
    if current_user.plan
      @user_plan = current_user.plan
      @plans = Plan.all
    else
      
    end
  end
  
  def edit_payment
    @subscription = current_user.subscription
    @user = current_user
  end
  
  def edit_password
    @subscription = current_user.subscription
    @user = current_user
  end
  
  def update_payment
    @subscription = Subscription.find(params[:id])
    @subscription.attributes = params[:subscription]
    token = @subscription.stripe_card_token
    if @subscription.change_payment(token)
      redirect_to @subscription, :notice => "Payment information updated."
    else
      redirect_to root_path, :notice => "Something went wrong."
    end
  end
  
  def taste_profile
    @user = current_user
    resource = current_user
    @tags = current_user.tags
  end
  
  def check_signed_in
    if !current_user
      redirect_to "/home"
    end
  end
  
  def check_plan
    if !current_user.plan
      plans_path
    elsif current_user.plan
      "/dashboard"
    end
  end
  
  def stripe_event
    event_json = JSON.parse(request.body.read)
    logger.info event_json
  end
  
end
