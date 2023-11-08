class Category < ApplicationRecord
    # Relationships
    has_and_belongs_to_many :posts, join_table: 'categories_posts'
    has_and_belongs_to_many :image_resources, join_table: 'categories_image_resources'
  
    # Self-referential associations for hierarchy
    has_many :child_categories, class_name: 'Category', foreign_key: 'parent_id'
    belongs_to :parent_category, class_name: 'Category', optional: true, foreign_key: 'parent_id'
  
    # Validations
    validates :name, presence: true
    validates :description, presence: true
  
    # Friendly_id
    extend FriendlyId
    friendly_id :name, use: :slugged
    
    # Alters friendly ID if name changed
    def should_generate_new_friendly_id?
      name_changed?
    end
  
    # Scopes or instance methods for top-tier categories might be added here
    # For example, to get all top-tier categories:
    scope :top_tier, -> { where(parent_id: nil) }
  end
  