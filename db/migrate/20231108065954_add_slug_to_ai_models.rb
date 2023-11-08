class AddSlugToAiModels < ActiveRecord::Migration[7.0]
  def change
    add_column :ai_models, :slug, :string
    add_index :ai_models, :slug, unique: true
  end
end
