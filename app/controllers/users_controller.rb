class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:index, :edit, :update, 
                                        :destroy, :following, :followers,
                                        :activate, :thanks]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page] )
  end

  def following
    @title = "following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page] )
    render 'show_follow'
  end

  def followers
    @title = 'followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page] )
    render 'show_follow'
  end

  def new
    if signed_in?
      redirect_to @current_user
    end
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    if signed_in?
      redirect_to @current_user
    end

    whitelist = [ ENV["TESTER_1"], ENV["TESTER_2"], ENV["TESTER_3"] ]

    @user = User.new(params[:user])
    if whitelist.include?(@user.email)
      if @user.save
        # Send verification email
        @user.email_verifications.create!
        session[:email] = @user.email
        redirect_to action: :thanks
      else
        render 'new'
      end
    else
      flash[:error] = "Access is closed at this time. Thanks!"
      redirect_to root_url
    end
  end

  def thanks
    # Direct user to their email to finalize sign-up
    if session[:email].nil?
      redirect_to signup_url
    end
    @email = session[:email]
    reset_session
  end

  def verify_email
    # User clicked on link sent to their email address
    verification = EmailVerification.find_by_code(params[:id])
    if verification.nil?
      # activation codes do not match
      redirect_to root_url
    elsif !verification.active_link?
      # activation code "expired"
      redirect_to root_url
    else
      # activation code confirmed, activate user, sign-in user
      user = verification.user
      activate_user(user)
      verification.active_link = false; verification.save!;
      sign_in(user)
      flash[:success] = "Welcome!"
      redirect_to root_url
    end
  end

  def activate
    # to send a new activation link
    if session[:lock].nil?
      redirect_to signup_url
    else
      @user = User.new
      reset_session
    end
  end

  def resend
    # user filled out request to send new activation link
    @user = User.find_by_email(params[:user][:email])

    if @user.nil?
      redirect_to signup_url
    else
      e = @user.email_verifications.pop
      e.active_link = false; e.save! 
      @user.email_verifications.create!
      session[:email] = @user.email
      redirect_to action: :thanks
    end
  end

  def edit 
    # -- @user defined in before_filter
  end

  def update
    # -- @user defined in before_filter
    if @user.update_attributes(params[:user])
      flash.now[:success] = "Changes to your profile have been saved!"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.admin == false
      user.destroy
      flash[:success] = "User account removed successfully."
      redirect_to users_url
    else
      flash[:error] = "Admin account removal failed."
      redirect_to @current_user
    end
  end  

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end