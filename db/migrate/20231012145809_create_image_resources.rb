class CreateImageResources < ActiveRecord::Migration[7.0]
  def change
    create_table :image_resources do |t|
      t.string :alt_description

      t.timestamps
    end
  end
end
