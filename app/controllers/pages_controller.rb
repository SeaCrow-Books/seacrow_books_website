class PagesController < ApplicationController

    def home
      @page_title = 'Welcome' 
      @page_description = 'Home of high quality romance fiction'
      @featured_books = Publishing::Book.order(created_at: :desc).limit(4)
      @latest_posts = Blog::Post.latest_published
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

  end
  