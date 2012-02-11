class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def dashboard
    if current_user.plan
      @user_plan = current_user.plan
      @plans = Plan.all
    else
      
    end
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
  
end
