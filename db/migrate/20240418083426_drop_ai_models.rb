class DropAiModels < ActiveRecord::Migration[7.0]
  def up
    drop_table :ai_models, force: :cascade
  end

  def down
    create_table :ai_models do |t|
      t.string :name
      t.text :description
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string :slug
      t.index :slug, name: "index_ai_models_on_slug", unique: true
    end
  end
end
