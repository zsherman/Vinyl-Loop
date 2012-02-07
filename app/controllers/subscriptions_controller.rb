class SubscriptionsController < ApplicationController
  def new
    plan = Plan.find(params[:plan_id])
    @subscription = plan.subscriptions.build
    current_user.plan_id = @subscription.plan_id
    current_user.save
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.user_id = current_user.id
    if @subscription.save_with_payment
      redirect_to @subscription, :notice => "Thank you for subscribing, you rock!"
    else
      render :new
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end
end
