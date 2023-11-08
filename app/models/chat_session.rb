class ChatSession < ApplicationRecord
    belongs_to :user
    belongs_to :chat_custom_instruction
    has_many :chats, dependent: :destroy 
    belongs_to :ai_model

    # Enums
    enum status: { status_public: 0, status_private: 1 }

    # Validations
    validates :session_name, presence: true
    validates :chat_custom_instruction_id, presence: true
    validates :user_id, presence: true
    validates :ai_model_id, presence: true

    # Scopes
    scope :public_or_owned_by, ->(user) { where(status: 'public').or(where(user: user)) }

end