class UsersController < ApplicationController

  before_filter :get_profile_params, only: :create
  before_filter :redirect_to_current_user, only: [:new, :create]
  before_filter :signed_in_user, only: [:index, :edit, :update, 
                                        :destroy, :following, :followers]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page] )
  end

  def following
    @title  = "following"
    @user   = User.find(params[:id])
    @users  = @user.followed_users.paginate(page: params[:page] )
    render 'show_follow'
  end

  def followers
    @title  = 'followers'
    @user   = User.find(params[:id])
    @users  = @user.followers.paginate(page: params[:page] )
    render 'show_follow'
  end

  def new 
    @user = User.new
    @profile = @user.build_person.build_profile
    # if params[:user][:profile_attributes]
    #   profile_params = params[:user].delete( :profile_attributes )
    #   @user = User.new(params[:user])
    #   @profile = @user.build_person.build_profile( profile_params )
    # else
    # end   
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page]) 
  end

  def create
    whitelist = [ ENV["TESTER_1"], ENV["TESTER_2"], ENV["TESTER_3"], 
                  ENV["TESTER_4"], ENV["TESTER_5"] ]

    if whitelist.include?(params[:user][:email]) 
      @user = User.new( params[:user] )
      @user.build_associations( @profile_params )
      if @user.save
        # Confirmation email sent after user record is saved
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

    def get_profile_params
      if params[:user][:profile_attributes]
        @profile_params = params[:user].delete(:profile_attributes)
      end
    end

end