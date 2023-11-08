class ChangeStatusInChatCustomInstructions < ActiveRecord::Migration[7.0]
  def change
    change_column :chat_custom_instructions, :status, :string
  end
end
