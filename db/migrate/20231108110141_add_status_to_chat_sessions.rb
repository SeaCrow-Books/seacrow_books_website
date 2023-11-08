class AddStatusToChatSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :chat_sessions, :status, :integer, default: 0
  end
end
