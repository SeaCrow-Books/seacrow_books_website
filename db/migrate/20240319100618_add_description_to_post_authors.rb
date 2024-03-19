class AddDescriptionToPostAuthors < ActiveRecord::Migration[7.1]
  def change
    add_column :post_authors, :description, :text
  end
end
