class AddModeToChatSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :chat_sessions, :mode, :string
  end
end
