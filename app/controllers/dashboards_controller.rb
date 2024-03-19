class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @page_title = "Dashboard"
    @books = Publishing::Book.all
    @genres = Publishing::Genre.all
    @authors = Publishing::Author.all
    @book_collections = Publishing::BookCollection.all
    @categories = Blog::Category.all
    @posts = Blog::Post.all
    @users = User.all
    @authors = Publishing::Author.all
    @writer_engagements = WriterEngagement.all
    @post_authors = Blog::PostAuthor.all
  end
  
end
