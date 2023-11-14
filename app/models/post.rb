class Post < ApplicationRecord
  include ViewTrackable # Allows views to be tracked

  # Relationships
  has_and_belongs_to_many :categories, join_table: 'categories_posts'
  belongs_to :persona
    
  # Callbacks
  before_save :set_meta_title
  before_save :set_publication_date

  # Validations
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true
  validates :slug, uniqueness: true
  validates :writer, presence: true 
  validates :persona_id, presence: true
  validates :description, length: { maximum: 250, message: "should not exceed 250 characters" }
  validates :meta_description, length: { maximum: 120, message: "should not exceed 120 characters" }
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
  scope :latest_published, -> { published.order(created_at: :desc) }

  private

  def set_meta_title
    self.meta_title = self.title if self.meta_title.blank? # Sets the meta_title to the title if blank
  end
    
  def set_publication_date
    self.published_at ||= Time.current # Set the publication date only if it's not set.
  end
end
