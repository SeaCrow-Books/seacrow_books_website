class AddPersonaToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :persona, foreign_key: true
  end
end
