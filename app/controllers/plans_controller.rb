class PlansController < ApplicationController
  before_filter :check_signed_in
  
  def index
    @plans = Plan.order("price")
  end
  
  def check_signed_in
    if !current_user
      redirect_to "/home"
    end
  end
end