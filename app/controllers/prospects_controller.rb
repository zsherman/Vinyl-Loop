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
      redirect_to root_path, :notice => "Thanks! We'll try to get you an invite code soon."
    else
      redirect_to root_path, :notice => "This is embarrassing, something went wrong."
    end
  end
  
  def destroy
    @prospect = Prospect.find(params[:id])
    @prospect.destroy
    flash[:notice] = "Prospect has been destroyed."
  end
end
