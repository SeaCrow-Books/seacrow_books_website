class RemoveAuthorFromBookCollections < ActiveRecord::Migration[7.1]
  def change
    remove_reference :book_collections, :author, null: false, index: true
  end
end
