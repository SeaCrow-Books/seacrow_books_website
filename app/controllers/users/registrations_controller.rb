class Users::RegistrationsController < Devise::RegistrationsController
    before_action :check_registration_permission, only: :create
  
    private
  
    def check_registration_permission
      unless SiteConfig.first.allow_new_accounts
        redirect_to new_user_registration_path, alert: "New account creation is currently disabled."
      end
    end
end