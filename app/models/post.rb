class Post < ApplicationRecord
  # Relationships
  has_and_belongs_to_many :categories, join_table: 'categories_posts'
    
  # Callbacks
  before_save :set_meta_title
  before_save :set_publication_date

  # Validations
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true
  validates :slug, uniqueness: true
  validates :writer, presence: true
  validates :description, length: { maximum: 250 }
  validates :meta_description, length: { maximum: 120 }
  validates :main_image_alt_text, length: { maximum: 125, message: "should not exceed 125 characters" }
  
  # For ActiveStorage attachment validation:
  # Ensure you have custom validation or a gem for this:
  validates :main_image, image_content_type: true 

  # Attachments
  has_one_attached :main_image

  # Friendly_id
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates # Looks for custom_url, if blank, it uses the title
    [
      :custom_url,
      :title
    ]
  end
  
  def should_generate_new_friendly_id?  # Ensure the slug is updated if the title changes
    custom_url_changed? || title_changed? || super
  end
  
  # Scopes
  scope :published, -> { where(published: true) }
  
  # This scope returns the post with the highest number of views.
  scope :most_viewed, -> {
    select('posts.*, COUNT(ahoy_events.id) as view_count')
    .joins("INNER JOIN ahoy_events ON ahoy_events.name = CONCAT('Post:', posts.id)")
    .group('posts.id')
    .order('view_count DESC')
    .limit(1)
  }

  private

  def set_meta_title
    self.meta_title = self.title if self.meta_title.blank? # Sets the meta_title to the title if blank
  end
    
  def set_publication_date
    self.published_at ||= Time.current # Set the publication date only if it's not set.
  end
end
