class AddDocumentUrlToPersonaVersions < ActiveRecord::Migration[7.0]
  def change
    add_column :persona_versions, :document_url, :string
  end
end
