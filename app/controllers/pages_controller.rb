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
   end
   
   def stripe_event
     event_json = JSON.parse(request.body.read)
     Rails.logger.info(params.inspect)
     logger.info "event_json"
   end
end
