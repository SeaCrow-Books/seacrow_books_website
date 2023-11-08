class AddStatusToChatCustomInstructions < ActiveRecord::Migration[7.0]
  def change
    add_column :chat_custom_instructions, :status, :boolean, default: true
  end
end
