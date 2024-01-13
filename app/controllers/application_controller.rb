class ApplicationController < ActionController::Base
    include Pundit::Authorization

    before_action :configure_permitted_parameters, if: :devise_controller? # sets up params white list for user
    before_action :set_variables_for_navbar

    after_action :verify_authorized, unless: :devise_controller?

    # Sets variables for navbar
    def set_variables_for_navbar
      @all_books = Publishing::Book.all
      @all_authors = Publishing::Author.all
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
      dashboard_path # Your path may vary
    end

end
