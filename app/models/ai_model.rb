class AiModel < ApplicationRecord
    has_many :chat_sessions, dependent: :destroy
end
