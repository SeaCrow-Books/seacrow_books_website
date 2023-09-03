class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :slug
      t.datetime :published_at
      t.string :writer

      t.timestamps
    end
    add_index :posts, :slug, unique: true
  end
end
