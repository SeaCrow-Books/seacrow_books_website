class ApplicationController < ActionController::Base
    include Pundit::Authorization

    before_action :configure_permitted_parameters, if: :devise_controller? # sets up params white list for user

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
