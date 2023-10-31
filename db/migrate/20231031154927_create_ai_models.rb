class CreateAiModels < ActiveRecord::Migration[7.0]
  def change
    create_table :ai_models do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
