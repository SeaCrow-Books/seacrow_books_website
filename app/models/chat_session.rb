class ChatSession < ApplicationRecord
    has_many :chats, dependent: :destroy
end