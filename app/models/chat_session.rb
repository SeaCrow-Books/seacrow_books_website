class ChatSession < ApplicationRecord
    has_many :chats, dependent: :destroy
    validates :mode, presence: true
end