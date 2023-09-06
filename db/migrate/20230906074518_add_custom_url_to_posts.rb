class AddCustomUrlToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :custom_url, :string
  end
end
