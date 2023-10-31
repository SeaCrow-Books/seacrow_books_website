class ChatSession < ApplicationRecord
    belongs_to :user
    belongs_to :chat_custom_instruction
    has_many :chats, dependent: :destroy 
    belongs_to :ai_model
end