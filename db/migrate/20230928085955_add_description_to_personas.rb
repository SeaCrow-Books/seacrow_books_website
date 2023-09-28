class AddDescriptionToPersonas < ActiveRecord::Migration[7.0]
  def change
    add_column :personas, :description, :text
  end
end
