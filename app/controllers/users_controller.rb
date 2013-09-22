class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
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
        redirect_to about_url
      end
  	else
  		redirect_to root_url
  	end
  end

  def verify_email
    verification = EmailVerification.find_by_code(params[:id])
    if verification.nil?
      flash[:error] = "Invalid email verification code"
      redirect_to root_url
    else
      user = verification.user
      self.current_user = user
      flash[:success] = "Email verified. Your profile is active!"
      redirect_to user
    end
  end

  def edit 
    #@user = User.find(params[:id]) -- @user defined in before_filter
  end

  def thanks
    @email = session[:email]
    reset_session
  end

  def update
    #@user = User.find(params[:id]) -- @user defined in before_filter
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
