class CreateChatCustomInstructions < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_custom_instructions do |t|
      t.string :name
      t.text :instruction_text

      t.timestamps
    end
  end
end
