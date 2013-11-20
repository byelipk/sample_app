class StaticPagesController < ApplicationController

  def home 
  	if signed_in?
  		
    else
      @user = User.new
      @profile = @user.build_associations
  	end 
  end

  def help
  end

  def about
  end

  def contact
  end

end
