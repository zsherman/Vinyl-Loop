class SubscriptionsController < ApplicationController
  def new
    plan = Plan.find(params[:plan_id])
    @subscription = plan.subscriptions.build
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    @user = User.find(current_user.id)
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.address = params[:address]
    @user.state = params[:state]
    @user.city = params[:city]
    @user.zip_code = params[:zip_code]
    #fix by passing in current user and setting in model @subscription.user_id = current_user.id
      if @subscription.save_with_payment(@user)
        redirect_to @subscription, :notice => "Thank you for subscribing, you rock!"
      else
        render :new
      end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end
  
  def edit
    @plan = Plan.find(params[:plan_id])
    @subscription = Subscription.find(params[:id])
    @subscription.plan_id = @plan.id
  end
  
  def update
    @subscription = Subscription.find(params[:id])
    @subscription.attributes = params[:subscription]
    if @subscription.update_with_payment
      redirect_to @subscription, :notice => "Enjoy your new subscription!"
    else
      redirect_to root_path, :notice => "Something went wrong."
    end
  end
  
  def edit_payment
    @subscription = current_user.subscription
  end
  
  def update_payment
    @subscription = Subscription.find(params[:id])
    @subscription.attributes = params[:subscription]
    @subscription.stripe_card_token = params[:stripe_card_token]
    if @subscription.change_payment
      redirect_to @subscription, :notice => "Payment information updated."
    else
      redirect_to root_path, :notice => "Something went wrong."
    end
  end
  
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.deactivate_subscription
    redirect_to "/dashboard"
  end
  
end
