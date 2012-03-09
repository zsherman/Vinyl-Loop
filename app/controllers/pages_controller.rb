class PagesController < ApplicationController
  def home
     @title = "Home"
     if current_user
       redirect_to "/dashboard"
     else
       
     end  
  end

   def contact
     @title = "Contact"
   end

   def about
     @title = "About"
   end

   def help
     @title = "Help"
   end

   def dashboard
     @title = "Dashboard"
     logger.info "dashboard"
   end
end
