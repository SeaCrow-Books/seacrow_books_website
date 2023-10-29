class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.string :user_input
      t.string :bot_response

      t.timestamps
    end
  end
end
