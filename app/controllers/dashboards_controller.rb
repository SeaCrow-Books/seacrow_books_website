class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @books = Book.all
    @genres = Genre.all
    @categories = Category.all
    @posts = Post.all
  end

  def update_account_creation_permission
    config = SiteConfig.first
    config.toggle!(:allow_new_accounts) # This will change the value of the attribute to its opposite.
    redirect_to dashboard_path, notice: "Configuration updated!"
  end
  
  private
  
  def site_config_params
    params.require(:site_config).permit(:allow_new_accounts)
  end
  
end
