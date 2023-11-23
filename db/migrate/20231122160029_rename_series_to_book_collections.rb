class RenameSeriesToBookCollections < ActiveRecord::Migration[7.1]
  def change
    rename_table :series, :book_collections
  end
end
