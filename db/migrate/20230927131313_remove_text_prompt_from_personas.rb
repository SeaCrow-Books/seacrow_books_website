class RemoveTextPromptFromPersonas < ActiveRecord::Migration[7.0]
  def change
    remove_column :personas, :text_prompt, :text
  end
end
