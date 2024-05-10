class ApplicationController < ActionController::Base
  before_action :authenticate_if_staging
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller? # sets up params white list for user
  before_action :set_variables_for_navbar

  # Sets variables for navbar
  def set_variables_for_navbar
    @all_books = Book.all
    @all_authors = Author.all
    @all_series = BookCollection.all
    @all_genres = BookGenre.all
    @all_tropes = BookTrope.all
  end

  protected

  # Params for User
  def configure_permitted_parameters
    # For signing up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role])

    # For editing account details
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :role])
  end

  # Redirect after sign in
  def after_sign_in_path_for(resource)
    blog_dashboard_path
  end

  # Have to log in for staging
  def authenticate_if_staging
    if request.host == 'staging.seacrowbooks.com'
      authenticate_user! # Devise method to ensure user is logged in
    end
  end

end
