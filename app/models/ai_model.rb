class AiModel < ApplicationRecord
    has_many :chat_sessions, dependent: :destroy

    # Friendly_id
    extend FriendlyId
    friendly_id :name, use: :slugged
        
    # Alters friendly ID if title changed
    def should_generate_new_friendly_id?
        name_changed?
    end 

end
