class DropChats < ActiveRecord::Migration[7.1]
  def up
    drop_table :chats
  end

  def down
    create_table :chats do |t|
      t.string :user_input
      t.string :bot_response
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.text :messages
      t.bigint :chat_session_id
      t.string :role
      t.text :content
      t.index :chat_session_id, name: "index_chats_on_chat_session_id"
    end
  end
end
