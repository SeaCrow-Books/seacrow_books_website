module Blog 
  class PostAuthor < ApplicationRecord
    has_many :posts

    # Attachments
    has_one_attached :image

    # Validations
    validates :name, presence: true
    validates :description, presence: true
    validates :image, image_content_type: true 

    # Friendly_id
    extend FriendlyId
    friendly_id :name, use: :slugged
    
    # Alters friendly ID if name changed
    def should_generate_new_friendly_id?
      name_changed?
    end

  end
end
