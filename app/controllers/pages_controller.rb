class PagesController < ApplicationController
  def home
     @title = "Home"
     if user_signed_in?
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
     if user_signed_in?
     end
   end
end
