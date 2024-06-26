class ImageResource < ApplicationRecord
    acts_as_taggable 

    attr_accessor :new_tag 

    # Relationships
    belongs_to :category
    
    # Attachments
    has_one_attached :image
    has_rich_text :notes

    # Validations
    validates :name, presence: true, uniqueness: { message: "must be unique" }
    validates :image_type, presence: true
    validates :alt_description, presence: true
    validates :image, presence: true, file_content_type: { in: %w(image/webp)}
    validates :category, presence: true
    
    # Friendly_id
    extend FriendlyId
    friendly_id :name, use: :slugged

    def should_generate_new_friendly_id?
        name_changed?
    end 
end
