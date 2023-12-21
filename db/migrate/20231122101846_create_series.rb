class CreateSeries < ActiveRecord::Migration[7.1]
  def change
    create_table :series do |t|
      t.string :name
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
