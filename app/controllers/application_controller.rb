class ApplicationController < ActionController::Base
	
  	protect_from_forgery
  	include SessionsHelper

  	# Force signout to prevent CSRF attacks
  	def handle_unverified_request
    	sign_out
    	super
  	end

   # For when we need AJAX flash messages...	
   #  after_filter :flash_to_headers
   #  def flash_to_headers
   #      return unless request.xhr?
   #      response.headers["X-Message"] = flash_message
   #      response.headers["X-Message-Type"] = flash_type.to_s

   #      flash.discard # don't want the flash to appear when you reload page
   #  end 

   # private

   #  def flash_message
   #      [:error, :warning, :notice].each do |type|
   #          return flash[type] unless flash[type].blank?
   #      end
   #  end

   #  def flash_type
   #      [:error, :warning, :notice].each do |type|
   #          return type unless flash[type].blank?
   #      end
   #  end	 
end
