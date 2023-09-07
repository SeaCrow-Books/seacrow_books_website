class RemoveAuthorNameFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :author_name, :string
  end
end
