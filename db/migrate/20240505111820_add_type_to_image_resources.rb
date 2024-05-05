class AddTypeToImageResources < ActiveRecord::Migration[7.1]
  def change
    add_column :image_resources, :type, :string
  end
end
