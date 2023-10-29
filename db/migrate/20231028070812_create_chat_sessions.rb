class CreateChatSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_sessions do |t|
      t.timestamps
    end
    
    change_table :chats do |t|
      t.references :chat_session, foreign_key: true
    end
  end
end
