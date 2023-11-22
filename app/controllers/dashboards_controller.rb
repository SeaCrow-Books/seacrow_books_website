class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @page_title = "Dashboard"
    @books = Publishing::Book.all
    @genres = Publishing::Genre.all
    @categories = Blog::Category.all
    @posts = Blog::Post.all
    @users = User.all
    @authors = Publishing::Author.all
  end
  
end
