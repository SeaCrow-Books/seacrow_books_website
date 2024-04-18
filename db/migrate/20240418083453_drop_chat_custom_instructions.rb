class DropChatCustomInstructions < ActiveRecord::Migration[7.1]
  def up
    drop_table :chat_custom_instructions, force: :cascade
  end

  def down
    create_table :chat_custom_instructions do |t|
      t.string :name
      t.text :instruction_text
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.bigint :user_id
      t.string :slug
      t.string :status, default: "true"
      t.index :slug, name: "index_chat_custom_instructions_on_slug", unique: true
      t.index :user_id, name: "index_chat_custom_instructions_on_user_id"
    end
  end
end

