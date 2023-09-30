class Category < ApplicationRecord

    # Relationships
    has_and_belongs_to_many :posts, join_table: 'categories_posts'

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
    
end
