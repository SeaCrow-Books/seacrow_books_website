class AddSessionNameToChatSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :chat_sessions, :session_name, :string
  end
end
