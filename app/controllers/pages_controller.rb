class PagesController < ApplicationController

    def index
      @page_title = 'Welcome' 
      @page_description = 'Home of high quality erotic fiction'
      @featured_books = Book.order(created_at: :desc).limit(4)
      @latest_posts = Post.published.most_viewed(10)
    end

    def about
      @page_title = 'About' 
      @page_description = 'Learn more about Seacrow Books'
    end
  
    def contact
      @page_title = 'Get in Touch' 
      @page_description = 'Share your thoughts and ideas'
    end

  end
  