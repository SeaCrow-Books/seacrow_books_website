module Blog
    class ImageResource < ApplicationRecord
        acts_as_taggable 

        attr_accessor :new_tag 

        # Relationships
        has_and_belongs_to_many :categories, join_table: 'categories_image_resources'
        
        # Attachments
        has_one_attached :image
        has_rich_text :notes

        # Validations
        validates :name, presence: true, uniqueness: true
        validates :alt_description, presence: true
        validates :image, presence: true, image_content_type: true 
        
        # Friendly_id
        extend FriendlyId
        friendly_id :name, use: :slugged

        def should_generate_new_friendly_id?
            name_changed?
        end 
    end
end