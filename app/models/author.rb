
    class Author < ApplicationRecord

        # Relationships
        has_many :books

        # Validations
        validates :name, presence: true

        # Friendly ID
        extend FriendlyId
        friendly_id :name, use: :slugged

        def should_generate_new_friendly_id?
            name_changed?
        end 
    end

