class CreateWriterEngagements < ActiveRecord::Migration[7.1]
  def change
    create_table :writer_engagements do |t|
      t.string :email
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
