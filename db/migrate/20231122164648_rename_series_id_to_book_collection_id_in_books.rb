class RenameSeriesIdToBookCollectionIdInBooks < ActiveRecord::Migration[7.1]
  def change
    rename_column :books, :series_id, :book_collection_id
  end
end
