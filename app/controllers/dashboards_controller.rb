class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def blog
    @page_title = "Blog Dashboard"
    @categories = Blog::Category.all
    @posts = Blog::Post.all
    @post_authors = Blog::PostAuthor.all
  end

  def book
    @page_title = "Book Dashboard"
    @books = Book.all
    @genres = BookGenre.all
    @tropes = BookTrope.all
    @authors = Author.all
    @book_collections = BookCollection.all
  end

  def admin
    @page_title = "Admin Dashboard"
    @users = User.all
    @writer_engagements = WriterEngagement.all
  end
  
end
