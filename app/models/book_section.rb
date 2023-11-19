class BookSection < ApplicationRecord
  # FriendlyId
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Associations
  belongs_to :book

  # Validations
  validates :title, :content, :position, presence: true
  validates :epub_type, presence: true
  
  before_save :should_generate_new_friendly_id?, if: :title_changed?
  before_validation :set_default_position, on: :create


  # Scopes (if any)
  # scope :your_scope_name, -> { order(:field_name) }

  # Class Methods
  def self.epub_types
    {
      'abstract' => 'frontmatter',
      'acknowledgments' => 'frontmatter',
      'appendix' => 'backmatter',
      'bibliography' => 'backmatter',
      'chapter' => 'bodymatter',
      'colophon' => 'backmatter',
      'contributors' => 'frontmatter',
      'copyright-page' => 'frontmatter',
      'credits' => 'frontmatter',
      'dedication' => 'frontmatter',
      'errata' => 'frontmatter',
      'foreword' => 'frontmatter',
      'frontispiece' => 'frontmatter',
      'halftitlepage' => 'frontmatter',
      'imprint' => 'frontmatter',
      'index' => 'backmatter',
      'keywords' => 'frontmatter',
      'other-credits' => 'frontmatter',
      'preface' => 'frontmatter',
      'prologue' => 'frontmatter',
      'revision-history' => 'frontmatter',
      'seriespage' => 'frontmatter',
      'titlepage' => 'frontmatter'
    }
  end
  

  # Instance Methods
  private

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  def set_default_position
    self.position = book.book_sections.maximum(:position).to_i + 1
  end
end

