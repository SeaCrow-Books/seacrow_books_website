class AddPromptToPersonaVersions < ActiveRecord::Migration[7.0]
  def change
    add_column :persona_versions, :prompt, :text
  end
end
