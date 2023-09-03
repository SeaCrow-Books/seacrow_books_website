class Post < ApplicationRecord

    # Validations
    validates :title, presence: true, uniqueness: { case_sensitive: false }
    validates :content, presence: true
    validates :slug, uniqueness: true
    validates :writer, presence: true

    # Friendly_id
    extend FriendlyId
    friendly_id :title, use: :slugged
            
    # Alters friendly ID if title changed
    def should_generate_new_friendly_id?
        title_changed?
    end 
    
    # Scopes (optional)
    # For example, a scope to retrieve all published posts
    scope :published, -> { where("published_at <= ?", Time.now) }
    
  end
  
