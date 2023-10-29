class AddRoleAndContentToChats < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :role, :string
    add_column :chats, :content, :text
  end
end
