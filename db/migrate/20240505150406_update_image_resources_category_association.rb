class UpdateImageResourcesCategoryAssociation < ActiveRecord::Migration[7.1]
  def change
    # Dropping the join table is only safe if you don't need the data anymore.
    # Ensure you have a backup or a plan if you need to preserve existing relationships.
    drop_table :categories_image_resources

    # Add a category_id column to the image_resources table.
    # This sets up a foreign key relationship to the categories table.
    add_reference :image_resources, :category, null: true, foreign_key: true
  end
end
