class SiteConfigsController < ApplicationController

    def update_account_creation_permission
      config = SiteConfig.first
      config.toggle!(:allow_new_accounts) # This will change the value of the attribute to its opposite.
      redirect_to dashboard_path, notice: "Users creation status updated!"
    end
    
    private
    
    def site_config_params
      params.require(:site_config).permit(:allow_new_accounts)
    end
    
end
  