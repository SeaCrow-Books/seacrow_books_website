class AddAiVersionToPersonas < ActiveRecord::Migration[7.0]
  def change
    add_column :personas, :ai_version, :string
  end
end
