class RemovePersonaIdFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :posts, :personas
    remove_index :posts, :persona_id
    remove_column :posts, :persona_id
  end
end
