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
  validates :meta_description, length: { maximum: 120 }

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

  private

  def set_meta_title
    self.meta_title = self.title if self.meta_title.blank? # Sets the meta_title to the title if blank
  end
    
  def set_publication_date
    self.published_at = Time.current
  end
  
end
  
