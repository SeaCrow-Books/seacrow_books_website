class PagesController < ApplicationController

    def home
      @page_title = 'Welcome' 
      @page_description = 'Home of high quality romance fiction'
      @featured_books = Book.all.order(series_number: :asc)
      @latest_posts =  Post.regular_posts.limit(9)
    end

    def about
      @page_title = 'About' 
      @page_description = 'Learn more about Seacrow Books'
    end
  
    def contact
      @page_title = 'Get in Touch' 
      @page_description = 'Share your thoughts and ideas'
    end

    def privacy_policy
      @page_title = 'Privacy Policy' 
      @page_description = 'Discover our privacy policy'
    end

    def trigger_support
      @page_title = 'Trigger Support' 
      @page_description = 'Support and Resources'
    end

  end
  