module SessionsHelper

  def sign_in(user)
    # Check if user account has been activated
    if user.activated?
      cookies.permanent[:remember_token] = user.remember_token
      # This syntax invokes current_user=(), thereby setting @current_user automagically :)
      self.current_user = user
    else
      # Unactivated account
    end
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please log in."        
    end
  end

  def current_user=(user)
    @current_user = user
  end 

  def signed_in?
    !current_user.nil?
  end  

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end  

  def current_user?(user)
    current_user == user
  end

  def sign_out
  	self.current_user = nil
  	cookies.delete(:remember_token)
  end

  def redirect_back_or(default, flash = {})
    if !flash.empty?
      key   = flash.first[0]
      value = flash.first[1]
      redirect_to( session[:return_to] || default, key => value )    
    else
      redirect_to( session[:return_to] || default )
    end
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

end