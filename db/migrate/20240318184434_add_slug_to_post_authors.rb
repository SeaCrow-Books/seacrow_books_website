class AddSlugToPostAuthors < ActiveRecord::Migration[7.1]
  def change
    add_column :post_authors, :slug, :string
    add_index :post_authors, :slug, unique: true
  end
end
