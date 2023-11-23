module Publishing
  class BookCollection < ApplicationRecord
    
    # Relationships
    belongs_to :author
    has_many :books

    extend FriendlyId
    friendly_id :name, use: :slugged
  
    # Setup FriendlyID to regenerate the slug if the name changes
    def should_generate_new_friendly_id?
      name_changed? || super
    end
  
  end
end
