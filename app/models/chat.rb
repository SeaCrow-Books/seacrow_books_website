class Chat < ApplicationRecord
  belongs_to :chat_session

  def self.process_message(content)
    # Interact with the API and return the response
    OpenaiService.chat(content)
  end
end

  