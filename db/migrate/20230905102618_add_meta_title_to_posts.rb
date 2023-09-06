class AddMetaTitleToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :meta_title, :string
  end
end
