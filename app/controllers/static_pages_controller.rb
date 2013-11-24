class StaticPagesController < ApplicationController

  def home 
  	unless signed_in?
      @static_page_forms = StaticPageForms.new
  	end 
  end

  def help
  end

  def about
  end

  def contact
  end
    
end
