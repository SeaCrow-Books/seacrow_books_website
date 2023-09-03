class PagesController < ApplicationController

    def index
      flash[:success] = "Great! Your post has been created!"
    end

    def about
    end
  
    def contact
    end

  end
  