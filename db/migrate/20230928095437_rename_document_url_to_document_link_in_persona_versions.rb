class RenameDocumentUrlToDocumentLinkInPersonaVersions < ActiveRecord::Migration[7.0]
  def change
    rename_column :persona_versions, :document_url, :document_link
  end
end
