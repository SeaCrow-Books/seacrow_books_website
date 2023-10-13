class AddSlugToImageResources < ActiveRecord::Migration[7.0]
  def change
    add_column :image_resources, :slug, :string
    add_index :image_resources, :slug, unique: true
  end
end
