class AddSlugToPersonas < ActiveRecord::Migration[7.0]
  def change
    add_column :personas, :slug, :string
    add_index :personas, :slug, unique: true
  end
end
