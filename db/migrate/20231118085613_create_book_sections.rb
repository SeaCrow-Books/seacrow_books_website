class CreateBookSections < ActiveRecord::Migration[7.1]
  def change
    create_table :book_sections do |t|
      t.string :title
      t.text :content
      t.integer :position
      t.string :epub_type
      t.references :book, null: false, foreign_key: true
      t.string :slug

      t.timestamps
    end
    add_index :book_sections, :slug, unique: true
  end
end
