class AddVersionToPersonas < ActiveRecord::Migration[7.0]
  def change
    add_column :personas, :version, :string, default: '1.0'
  end
end
