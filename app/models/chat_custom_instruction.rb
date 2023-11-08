class ChatCustomInstruction < ApplicationRecord
    belongs_to :user
    has_one :chat_session

    validates :name, presence: true
    validates :instruction_text, presence: true
    validates :status, presence: true

    #enums
    enum status: { visibility_private: 'private', visibility_public: 'public' }
    
    # Friendly_id
    extend FriendlyId
    friendly_id :name, use: :slugged
    
     # Alters friendly ID if title changed
    def should_generate_new_friendly_id?
        name_changed?
    end
     
    # Scopes
    scope :public_or_owned_by, ->(user) { where(status: true).or(where(user: user)) }

end
