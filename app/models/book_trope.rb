class BookTrope < ApplicationRecord

    has_many :books
    
    validates :name, presence: true

    # Friendly_id
    extend FriendlyId
    friendly_id :name, use: :slugged
        
    # Alters friendly ID if name changed
    def should_generate_new_friendly_id?
        name_changed?
    end 
    
end
