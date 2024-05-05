class RemoveImageFromImageResources < ActiveRecord::Migration[7.1]
  def change
    remove_column :image_resources, :type, :string
  end
end
