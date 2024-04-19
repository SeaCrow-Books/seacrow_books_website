class RemoveBooksGenresJoinTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :books_genres
  end
end
