class RemoveModeFromChatSessions < ActiveRecord::Migration[7.0]
  def change
    remove_column :chat_sessions, :mode, :string
  end
end
