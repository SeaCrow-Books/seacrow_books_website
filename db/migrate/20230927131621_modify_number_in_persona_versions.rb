class ModifyNumberInPersonaVersions < ActiveRecord::Migration[7.0]
  def change
    change_column :persona_versions, :number, :decimal, precision: 3, scale: 1, default: 1.0
  end
end
