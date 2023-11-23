class AddTitleTagLineAndSeriesNumberToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :title_tag_line, :string
    add_column :books, :series_number, :integer
  end
end
