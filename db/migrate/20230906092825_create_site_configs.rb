class CreateSiteConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :site_configs do |t|
      t.boolean :allow_new_accounts, default: false

      t.timestamps
    end
  end
end
