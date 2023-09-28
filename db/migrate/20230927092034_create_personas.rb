class CreatePersonas < ActiveRecord::Migration[7.0]
  def change
    create_table :personas do |t|
      t.string :name
      t.text :text_prompt

      t.timestamps
    end
  end
end
