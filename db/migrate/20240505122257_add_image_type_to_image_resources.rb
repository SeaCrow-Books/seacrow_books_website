class AddImageTypeToImageResources < ActiveRecord::Migration[7.1]
  def change
    add_column :image_resources, :image_type, :string
  end
end
