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
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to Kshizzy!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit 
    #@user = User.find(params[:id]) -- @user defined in before_filter
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
