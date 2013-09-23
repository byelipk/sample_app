module SessionsHelper

  # ARGS: User object
  # RETURN VALUE: Stores a cookie for user authentication, 
  # -- and instantiates @current_user
  def sign_in(user)
    # Check if user account has been activated
    if activated?(user)
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

  # ARGS: User object
  # RETURN VALUE: @current_user
  def current_user=(user)
    @current_user = user
  end 

  # ARGS: none
  # RETURN VALUE: Boolean
  def signed_in?
    !current_user.nil?
  end  

  # ARGS: none
  # RETURN VALUE: 
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end  

  # ARGS: User object
  # RETURN VALUE: Boolean; compares current user to the user 
  # -- whose page current user requested acces to 
  def current_user?(user)
    current_user == user
  end

  # ARGS: none
  # RETURN VALUE: Sets @current_user to nil and deletes remember_token
  def sign_out
  	self.current_user = nil
  	cookies.delete(:remember_token)
  end

  # ARGS: 
  # RETURN VALUE: Redirects user to requested URL, or re-routes user to default url
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def activate_user(user)
    user.active = true
    user.verified_email = true
    user.save(validate: false)
  end

  def activated?(user)
    user.active != false
  end

  def registered?(user)
    
  end

end
