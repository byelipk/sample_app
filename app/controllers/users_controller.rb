class UsersController < ApplicationController

  # SessionsHelper methods
  before_filter :redirect_to_current_user, only: [:new, :create]
  before_filter :signed_in_user, only: [:index, :edit, :update, 
                                        :destroy, :following, :followers]
  # Private methods
  before_filter :create_signup_params, only: :new
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page] )
  end

  def new 
    @user = User.new(user_params)
    @profile = @user.build_associations(profile_params)  
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    whitelist = [ ENV["TESTER_1"], ENV["TESTER_2"], ENV["TESTER_3"], 
                  ENV["TESTER_4"] ]

    if whitelist.include?(params[:user][:email]) 
      @user = User.new( user_params )
      @user.build_associations( profile_params )
      if @user.save
        session[:email] = @user.email
        redirect_to new_account_confirmation_url
      else
        render 'new'
      end
    else
      flash[:error] = "Access is closed at this time. Thanks!"
      redirect_to root_url
    end
  end

  def edit 
    # -- @user defined in before_filter
  end

  def update
    # -- @user defined in before_filter
    # if @user.update_attributes(params[:user].permit())
    #   flash.now[:success] = "Changes to your profile have been saved!"
    #   sign_in @user
    #   redirect_to @user
    # else
    #   render 'edit'
    # end
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

  def user_params
    params[:user].permit( :email, :password, :password_confirmation )
  end

  def profile_params
    params[:user][:profile_attributes].permit(:first_name, :last_name)
  end

  def create_signup_params
    if !params[:user]
      params[:user] = {profile_attributes: {first_name: "", last_name: ""}, 
                      email: "", password: "", password_confirmation: ""}
    end
  end

end