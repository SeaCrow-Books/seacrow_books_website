class Persona < ApplicationRecord
    # Associations
    has_many :posts
    has_many :persona_versions, dependent: :destroy

    accepts_nested_attributes_for :persona_versions

    # Validations
    validates :name, presence: true, uniqueness: true
    validates :content_type, presence: true
    validates :description, presence: true
    validates :ai_version, presence: true

    # Sets the type
    enum content_type: { post: 0, book: 1 }

    # Friendly_id
    extend FriendlyId
    friendly_id :name, use: :slugged
        
    # Alters friendly ID if title changed
    def should_generate_new_friendly_id?
        name_changed?
    end 

    # Scopes
    scope :for_posts, -> { where(content_type: 'post').order(created_at: :desc) }

end
