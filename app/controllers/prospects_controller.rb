class ProspectsController < ApplicationController
  def index
    @prospect = Prospect.all
  end
  
  def new
    @prospect = Prospect.new
  end
  
  def create
    @prospect = Prospect.new(params[:prospect])
    if @prospect.save
      flash[:notice] = "Thanks! We'll let you know when spots open up."
      redirect_to "/home"
    else
      flash[:notice] = "Sorry, something went wrong."
      redirect_to root_path
    end
  end
  
  def destroy
    @prospect = Prospect.find(params[:id])
    @prospect.destroy
    flash[:notice] = "Prospect has been destroyed."
    redirect_to root_path
  end
end
