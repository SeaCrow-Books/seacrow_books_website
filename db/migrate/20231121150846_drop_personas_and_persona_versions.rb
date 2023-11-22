class DropPersonasAndPersonaVersions < ActiveRecord::Migration[7.1]
  def up
    drop_table :persona_versions
    drop_table :personas
  end
end
