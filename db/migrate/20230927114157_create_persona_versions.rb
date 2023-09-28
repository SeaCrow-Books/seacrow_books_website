class CreatePersonaVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :persona_versions do |t|
      t.decimal :number,precision: 3, scale: 1
      t.references :persona, null: false, foreign_key: true

      t.timestamps
    end
  end
end
