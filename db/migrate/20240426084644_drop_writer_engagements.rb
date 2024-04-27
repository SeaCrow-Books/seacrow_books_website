class DropWriterEngagements < ActiveRecord::Migration[7.1]
  def change
    def up
      drop_table :writer_engagements
    end
  
    def down
      create_table :writer_engagements do |t|
        t.string :email
        t.bigint :post_id, null: false
        t.timestamps
      end
      add_index :writer_engagements, :post_id
    end
  end
end
