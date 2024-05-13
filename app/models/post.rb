
class Post < ApplicationRecord
  include ViewTrackable # Allows views to be tracked

  # Relationships
  has_and_belongs_to_many :categories, join_table: 'categories_posts'
  belongs_to :post_author, optional: true
    
  # Callbacks
  before_save :set_meta_title
  before_save :set_publication_date
  before_create :assign_unique_id

  # Validations
  validates :title, presence: true
  validates :content, presence: true
  validates :post_author, presence: true 
  validates :post_type, presence: true
  validates :description, length: { maximum: 250, message: "should not exceed 250 characters" }
  validates :meta_description, length: { maximum: 250, message: "should not exceed 250 characters" }
  validates :main_image_alt_text, length: { maximum: 125, message: "should not exceed 125 characters" }
  validates :main_image, file_content_type: { in: %w(image/webp)}

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
  scope :published, -> { where(published: true).order(created_at: :desc) }
  scope :ultimate_guides, -> { published.where(post_type: 'ultimate guide') }
  scope :essential_guides, -> { published.where(post_type: 'essential guide') }
  scope :regular_posts, -> { published.where(post_type: 'regular post') }    

  private

  def set_meta_title
    self.meta_title = self.title if self.meta_title.blank? # Sets the meta_title to the title if blank
  end
    
  def set_publication_date
    self.published_at ||= Time.current # Set the publication date only if it's not set.
  end

  def assign_unique_id
    self.id = next_unique_id
  end

  def next_unique_id
    max_id = Post.maximum(:id) || 0
    next_id = max_id.next
    while Post.exists?(id: next_id)
      next_id = next_id.next
    end
    next_id
  end
  
end
