module SessionsHelper

  def sign_in(user)
  	# Store user's remember token in a cookie; valid for 20 years
    cookies.permanent[:remember_token] = user.remember_token
    
    # Assign 'user' as the current session user
    # This syntax invokes current_user=(), thereby setting @current_user
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end  

  def current_user=(user)
  	@current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end  

  def sign_out
  	self.current_user = nil
  	cookies.delete(:remember_token)
  end
end
