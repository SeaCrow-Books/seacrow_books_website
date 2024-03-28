module Blog
  class Category < ApplicationRecord
    # Establishes the relationship to posts and image resources.
    has_and_belongs_to_many :posts, join_table: 'categories_posts'
    has_and_belongs_to_many :image_resources, join_table: 'categories_image_resources'

    # Self-referential associations for hierarchy.
    # Ensures that each category knows about its children (if any) and its parent (if any).
    has_many :child_categories, class_name: 'Blog::Category', foreign_key: 'parent_id', inverse_of: :parent_category
    belongs_to :parent_category, class_name: 'Blog::Category', optional: true, foreign_key: 'parent_id', inverse_of: :child_categories

    # Validations to ensure data integrity.
    validates :name, presence: true
    validates :description, presence: true

    # Uses FriendlyId for more readable URLs based on the category name.
    extend FriendlyId
    friendly_id :name, use: :slugged

    # Determines if a new slug needs to be generated when a category name changes.
    def should_generate_new_friendly_id?
      name_changed?
    end
  
    # A scope to easily fetch top-tier categories, which are those without a parent.
    scope :top_tier, -> { where(parent_id: nil) }

    # Instance methods to check a category's position in the hierarchy could remain here,
    # such as checking if a category is a root or if it has children.
    def root?
      parent_category.nil?
    end

    def leaf?
      child_categories.empty?
    end
  end
end
