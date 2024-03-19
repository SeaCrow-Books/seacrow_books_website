class AddPostAuthorIdToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :post_author_id, :integer
  end
end
