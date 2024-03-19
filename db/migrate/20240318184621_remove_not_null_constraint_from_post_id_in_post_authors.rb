class RemoveNotNullConstraintFromPostIdInPostAuthors < ActiveRecord::Migration[7.1]
  def change
    change_column_null :post_authors, :post_id, true
  end
end
