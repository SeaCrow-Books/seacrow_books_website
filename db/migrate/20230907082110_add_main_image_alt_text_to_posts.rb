class AddMainImageAltTextToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :main_image_alt_text, :string
  end
end
