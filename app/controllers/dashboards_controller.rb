class DashboardsController < ApplicationController
  # before_action :authenticate_user!

  def show
    @page_title = "Dashboard"
    @books = Book.all
    @genres = Genre.all
    @categories = Category.all
    @posts = Post.all
    @users = User.all
    @authors = Author.all
  end
  
end
