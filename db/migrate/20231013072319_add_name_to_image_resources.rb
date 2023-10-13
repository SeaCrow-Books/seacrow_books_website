class AddNameToImageResources < ActiveRecord::Migration[7.0]
  def change
    add_column :image_resources, :name, :string
  end
end
