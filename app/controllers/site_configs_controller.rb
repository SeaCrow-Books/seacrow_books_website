class SiteConfigsController < ApplicationController

    def update_account_creation_permission
      config = SiteConfig.first
      config.toggle!(:allow_new_accounts) # This will change the value of the attribute to its opposite.
      redirect_to dashboard_path, notice: "Users creation status updated!"
    end
    
    # This will run the seed if needed, it is turned off, need to uncomment the root to run - USE WITH CARE
    def run_seed
      system("rails db:seed")
      render plain: "Seeded successfully"
    end

    private
    
    def site_config_params
      params.require(:site_config).permit(:allow_new_accounts)
    end
    
end
  