class CreateBookTropes < ActiveRecord::Migration[7.1]
  def change
    create_table :book_tropes do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :book_tropes, :slug, unique: true
  end
end
