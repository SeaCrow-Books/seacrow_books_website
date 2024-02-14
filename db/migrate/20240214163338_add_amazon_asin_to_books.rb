class AddAmazonAsinToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :amazon_asin, :string
  end
end
