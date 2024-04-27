class RemovePostIdFromWriterEngagements < ActiveRecord::Migration[7.1]
  def change
    remove_column :writer_engagements, :post_id, :bigint
  end
end
