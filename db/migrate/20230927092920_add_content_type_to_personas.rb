class AddContentTypeToPersonas < ActiveRecord::Migration[7.0]
  def change
    add_column :personas, :content_type, :integer
  end
end
