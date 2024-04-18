class DropBookSections < ActiveRecord::Migration[7.1]
  def up
    drop_table :book_sections
  end

  def down
    create_table :book_sections do |t|
      t.string :title
      t.text :content
      t.integer :position
      t.string :epub_type
      t.bigint :book_id, null: false
      t.string :slug
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index [:book_id], name: "index_book_sections_on_book_id"
      t.index [:slug], name: "index_book_sections_on_slug", unique: true
    end
  end
end

