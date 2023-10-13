class CreateJoinTableCategoriesImageResources < ActiveRecord::Migration[7.0]
  def change
    create_join_table :categories, :image_resources do |t|
      # t.index [:category_id, :image_resource_id]
      # t.index [:image_resource_id, :category_id]
    end
  end
end
