class AddSeriesToBooks < ActiveRecord::Migration[7.1]
  def change
    add_reference :books, :series, foreign_key: true
  end
end
