module Publishing
  class Book < ApplicationRecord

    #Relationships
    belongs_to :book_collection
    has_and_belongs_to_many :genres, join_table: 'books_genres'

    #Attachments
    has_one_attached :cover

    # Validations
    validates :title, presence: true
    validates :description, presence: true
    validates :book_collection, presence: true
    validates :publication_date, presence: true
    validates :title_tag_line, presence: true
    validates :series_number, presence: true

    # validates :genre, presence: true

    # For ActiveStorage attachment validation:
    validates :cover, image_content_type: true


    # Callbacks
    before_save :set_author_from_book_collection

    # Friendly_id
    extend FriendlyId
    friendly_id :title, use: :slugged
      
    # Alters friendly ID if title changed
    def should_generate_new_friendly_id?
      title_changed?
    end 

    def set_author_from_book_collection
      # Check if a book_collection is associated with the book
      if book_collection.present?
        self.author_id = book_collection.author_id
      end
    end

    # Creates the Amazon link
    def amazon_url
      "https://www.amazon.com/dp/#{amazon_asin}" if amazon_asin.present?
    end

  end
end