class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @books = Book.all
    @genres = Genre.all
    @categories = Category.all
    @posts = Post.all
  end
end
