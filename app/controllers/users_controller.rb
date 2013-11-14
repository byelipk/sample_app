class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:index, :edit, :update, 
                                        :destroy, :following, :followers]
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
    @users = @user.followers.paginate( page: params[:page] )
    render 'show_follow'
  end

  def new
    redirect_to @current_user if signed_in?
    @user = User.new
    @user.build_person.build_profile
    if params.has_key?( :user )
      persist_user_data( params[:user] )
      if params[:user].has_key?(:profile_attributes)
        persist_profile_data( params[:user][:profile_attributes] )
      end
    else
      @user = User.new
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page]) 
  end

  def create

    redirect_to @current_user if signed_in?
   
    whitelist      = [ ENV["TESTER_1"], ENV["TESTER_2"], ENV["TESTER_3"] ]
    profile_params = params[:user].delete(:profile_attributes)

    @user = User.new(params[:user])
    if whitelist.include?(@user.email)
      if @user.save && @user.create_person.create_profile( profile_params )
        @user.send_confirmation_email
        session[:email] = @user.email
        redirect_to thank_you_url
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

    def persist_user_data( user_params )
      if user_params[:email]
        user_email = { "email" => user_params[:email] }
        @user = User.new( user_email )
      else
        @user = User.new
      end
    end

    def persist_profile_data( profile_params )   
      if profile_params[:first_name] && profile_params[:last_name]
        @profile = @user.build_person.build_profile( profile_params )
      end
    end
end