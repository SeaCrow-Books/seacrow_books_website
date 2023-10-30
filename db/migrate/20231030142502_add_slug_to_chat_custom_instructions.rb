class AddSlugToChatCustomInstructions < ActiveRecord::Migration[7.0]
  def change
    add_column :chat_custom_instructions, :slug, :string
    add_index :chat_custom_instructions, :slug, unique: true
  end
end
