module Publishing
  class Book < ApplicationRecord

  #Relationships
  belongs_to :author
  has_and_belongs_to_many :genres, join_table: 'books_genres'
  has_many :book_sections, dependent: :destroy

  #Attachments
  has_one_attached :cover

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :author_id, presence: true
  validates :publication_date, presence: true
  # validates :genre, presence: true

  # For ActiveStorage attachment validation:
  validates :cover, image_content_type: true

  # Friendly_id
  extend FriendlyId
  friendly_id :title, use: :slugged
    
  # Alters friendly ID if title changed
  def should_generate_new_friendly_id?
    title_changed?
  end 

  end
end