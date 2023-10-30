class AddChatCustomInstructionRefToChatSessions < ActiveRecord::Migration[7.0]
  def change
    add_reference :chat_sessions, :chat_custom_instruction, foreign_key: true
  end
end
