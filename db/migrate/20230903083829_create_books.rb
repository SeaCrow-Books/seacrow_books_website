class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :author_name
      t.date :publication_date
      t.string :genre

      t.timestamps
    end
  end
end
