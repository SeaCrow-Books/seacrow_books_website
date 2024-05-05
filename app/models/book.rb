
  class Book < ApplicationRecord

    #Relationships
    belongs_to :book_collection
    belongs_to :author
    belongs_to :book_genre
    belongs_to :book_trope

    #Attachments
    has_one_attached :cover
    has_one_attached :manuscript_pdf
    has_one_attached :manuscript_epub

    # Validations
    validates :title, presence: true
    validates :description, presence: true
    validates :book_collection, presence: true
    validates :publication_date, presence: true
    validates :title_tag_line, presence: true
    validates :series_number, presence: true
    validates :book_genre, presence: true
    validates :book_trope, presence: true
    validates :author, presence: true

    validates :manuscript_pdf, file_content_type: { in: %w(application/pdf) }
    validates :manuscript_epub, file_content_type: { in: %w(application/epub+zip) }
    validates :cover, file_content_type: { in: %w(image/webp)}

    # Friendly_id
    extend FriendlyId
    friendly_id :title, use: :slugged
      
    # Alters friendly ID if title changed
    def should_generate_new_friendly_id?
      title_changed?
    end 

    # Creates the Amazon link
    def amazon_url
      "https://www.amazon.com/dp/#{amazon_asin}" if amazon_asin.present?
    end

  end
