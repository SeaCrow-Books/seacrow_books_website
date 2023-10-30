class AddUserToChatSessions < ActiveRecord::Migration[7.0]
  def change
    add_reference :chat_sessions, :user, null: false, foreign_key: true
  end
end
