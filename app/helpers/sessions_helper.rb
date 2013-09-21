module SessionsHelper

  # ARGS: User object
  # RETURN VALUE: Stores a cookie for user authentication, 
  # -- and instantiates @current_user
  def sign_in(user)
  	# Store user's remember token in a cookie; valid for 20 years
    cookies.permanent[:remember_token] = user.remember_token
    
    # Assign 'user' as the current session user
    # This syntax invokes current_user=(), thereby setting @current_user
    self.current_user = user
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
end
