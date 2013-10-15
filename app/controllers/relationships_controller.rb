class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)

    respond_to do |format|
    	format.html { redirect_to @user }
    	format.js
    end
  end

  def destroy
  	# (1) Retrieve the Relationship object => Relationship.find(params[:id])
  	# (2) Fetch the User object by calling => Relationship.find(params[:id]).followed
    @user = Relationship.find(params[:id]).followed
    # (3) Destroy relationship by passing User object => current_user.unfollow!(@user)
    current_user.unfollow!(@user)

    # -- Assure action can respond to AJAX requests
    respond_to do |format|
    	format.html { redirect_to @user }
    	format.js
    end    
  end
end