class DropChatSessions < ActiveRecord::Migration[7.1]
  def up
    drop_table :chat_sessions, force: :cascade
  end

  def down
    create_table :chat_sessions do |t|
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string :session_name
      t.bigint :chat_custom_instruction_id
      t.bigint :user_id
      t.bigint :ai_model_id
      t.integer :status, default: 0
      t.index :ai_model_id, name: "index_chat_sessions_on_ai_model_id"
      t.index :chat_custom_instruction_id, name: "index_chat_sessions_on_chat_custom_instruction_id"
      t.index :user_id, name: "index_chat_sessions_on_user_id"
    end
  end
end
