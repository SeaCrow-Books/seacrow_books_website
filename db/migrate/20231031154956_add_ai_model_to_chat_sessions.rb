class AddAiModelToChatSessions < ActiveRecord::Migration[7.0]
  def change
    add_reference :chat_sessions, :ai_model, foreign_key: true
  end
end
