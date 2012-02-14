class ProspectsController < ApplicationController
  def index
    @prospect = Prospect.all
  end
  
  def new
    @prospect = Prospect.new
  end
  
  def create
    @prospect = Prospect.new(params[:prospect])
    check = Prospect.find_by_email(@prospect.email)
    if check == nil
      if @prospect.save
        @prospect.subscribe
        flash[:notice] = "Thanks! We'll let you know when spots open up."
        redirect_to "/home"
      else
        flash[:notice] = "Sorry, something went wrong."
        redirect_to "/home"
      end
    else
      flash[:notice] = "You've already been added to our list."
      redirect_to "/home"
    end
  end
  
  def destroy
    @prospect = Prospect.find(params[:id])
    @prospect.destroy
    flash[:notice] = "Prospect has been destroyed."
    redirect_to root_path
  end
  
  def subscribe
    h = Hominid::API.new('4d5460e70fba6abc2b50e4a2ecf1a18c-us4')
    h.subscribe(h.find_list_id_by_name("Prospects"), self.email, {:FNAME => prospect.email})
  end
end
