class Book < ApplicationRecord
  has_one_attached :cover
  has_and_belongs_to_many :genres, join_table: 'books_genres'

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :author_name, presence: true
  validates :publication_date, presence: true
  # validates :genre, presence: true

  # For ActiveStorage attachment validation (assuming you're not using a gem for this):
  validate :validate_cover
  
  # Friendly_id
  extend FriendlyId
  friendly_id :title, use: :slugged
    
  # Alters friendly ID if title changed
  def should_generate_new_friendly_id?
    title_changed?
  end 

  private
  
  def validate_cover
    if cover.attached? && !cover.content_type.in?(%w(image/jpeg image/png image/webp))
      errors.add(:cover, 'Must be a JPEG, PNG, or WEBP')
    end    
  end

end
